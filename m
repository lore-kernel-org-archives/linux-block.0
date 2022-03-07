Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA82C433EF
	for <linux-block@archiver.kernel.org>; Mon,  7 Mar 2022 13:52:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239002AbiCGNxX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 7 Mar 2022 08:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238915AbiCGNxX (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 7 Mar 2022 08:53:23 -0500
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C489913D02
        for <linux-block@vger.kernel.org>; Mon,  7 Mar 2022 05:52:27 -0800 (PST)
Received: by mail-pg1-x530.google.com with SMTP id o23so13585052pgk.13
        for <linux-block@vger.kernel.org>; Mon, 07 Mar 2022 05:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FpiH8sK6QJ5ZecNwA0soEekz+DBDXKgGF93HUqOWr2g=;
        b=3C80KwlAfecIpqsoXr/WQ/0If5ZLPxKUel30fSldQNh+QLi/6eRFRdZYMRUfVAEK60
         q1Tz2gW7OU0CuZS613xgjZfpk9iA8CNKv87I+FVqoZAL5PjH+CNyY/m39y88OJcfoeCY
         lFLtbwbOI1GWEeXXAfPQudyK2sWVrxK1qL64/NKjtX+fGVarDmEKqYqgPBddP1ylNjo3
         Bnk+YsbeEo4XWuoaSM49mf4Wz0Z+etvvQXT+S2GiwP+asuHMSS+/IDtF38qAuIAaf/l1
         9HtsYnmBy3rdrdClH8hTGW2YS7hqgFggJCNrGIVeeDYrPgmcNPiBirtZMfsVvpZFWLak
         /lMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FpiH8sK6QJ5ZecNwA0soEekz+DBDXKgGF93HUqOWr2g=;
        b=imLVImK9HIrGtkrArEzYCnVJ3D++oU3GEqKLbpn3RajUFqk2udk9McFJ7GW1XNvOgh
         hSrAzDK7PlUf5bBpGtfVuFrrHV5cQGtT2vYdL/rlhrf8EMLVGmMS2e45YT5/1R6+JMTI
         KbTAgBDSEIiD28i4xxduoFrc/k9azDGxevhQR7MO4SyYnwYivc2tewKp89w/Oj/Cxve5
         ktuE0q4yjPLB9phyNHjt2LJcCRYt++Lr6NuO+2vHW/HCi0NCFtkP568LW65nrYfFqXJQ
         pKvIkGPrilqDbbdnpCTiueUJrgW6szXar1bAl9y0vPMfPeHfO+BnDnzVq8lGLGX6zBjK
         /FAg==
X-Gm-Message-State: AOAM530hteojU8cg0TsjOILPo7WvZSnhtRh6io/AHDgOVtd8EB0uCl0B
        1dKZgaWppqz+uP3ehT+PyT9ZTpvDvbrNM0HZ
X-Google-Smtp-Source: ABdhPJz+/iGljhGAfM285WDdfPPis8SH9wGNMH/HdIzatH84Hr3uwQ2gayBqurPn+iZWNdoEmD1R0A==
X-Received: by 2002:a05:6a00:16d6:b0:4bf:325:de2f with SMTP id l22-20020a056a0016d600b004bf0325de2fmr12833983pfc.7.1646661147261;
        Mon, 07 Mar 2022 05:52:27 -0800 (PST)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id j9-20020a056a00234900b004f6feec0d6csm4550102pfj.2.2022.03.07.05.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 05:52:26 -0800 (PST)
Message-ID: <dbd1479d-09fe-aedc-3b43-5bd0cbebe555@kernel.dk>
Date:   Mon, 7 Mar 2022 06:52:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 2/2] fs: remove fs.f_write_hint
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <20220307104701.607750-1-hch@lst.de>
 <20220307104701.607750-3-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220307104701.607750-3-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/7/22 3:47 AM, Christoph Hellwig wrote:
> The value is now completely unused except for reporting it back through
> the F_GET_FILE_RW_HINT ioctl, so remove the value and the two ioctls
> for it.

This commit message could do with some verbiage on why the EINVAL
solution was chosen for the F_{GET,SET}_RW_HINT ioctls.

-- 
Jens Axboe

