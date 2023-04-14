Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F95FC77B72
	for <linux-block@archiver.kernel.org>; Fri, 14 Apr 2023 12:32:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbjDNMcW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Apr 2023 08:32:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbjDNMcV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Apr 2023 08:32:21 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35B85C1
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2023 05:32:18 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-63b621b1dabso223059b3a.0
        for <linux-block@vger.kernel.org>; Fri, 14 Apr 2023 05:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1681475537; x=1684067537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZzeAz/PFuhMt3rQNVFJc0aL0ecIBPs6lOaCHe0Gocvk=;
        b=xulOPWC1n1Kk+vOWWDltd/WbfV5XDGDD9HgwWAunkaENPoqTkuGXgDVkxkFJD3wXuP
         YpoylUfgTLk6F/mM/ynWzE12+9PvPAMnJVr10puRrpCn2cEtDJ9sJvruwGpFBjy7PHhS
         mk+oet2Cwc9Elixr3y59WDHcO+vcdbIkv1/AATVjlTo7h8OH1vwzmnX2Fmf7O+HCf8hW
         tWUOF2wtCQtVeQfQW7AZwnRLdn/syZTrNCGRXmlBLiR++wpEJYPlYbIPuXPXh2YQYkr3
         0gxoBEDUbozkyiaetDutHglho2Wta88vfDsBW8e3rOZ3BF6cmFKTW5d6X6ak1lxDjy11
         q9lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681475537; x=1684067537;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZzeAz/PFuhMt3rQNVFJc0aL0ecIBPs6lOaCHe0Gocvk=;
        b=TfMK1QF2qE+w5uuEGAZNZyaAosHAfYDbjtDR95BSgHdiIW/PAyqbxxKrayOwRiMcph
         pMrPsgJjpNPyPL/yfuFyMl8fUkC8EyaLULoJtVL3Sk9YiLYSKoXZiP2bkNjbjDQHWlSa
         iOUdJ5MPVK+q53sHGlDqPL6Na3bZ8KlCxRmkycbhY0/z7vdLQ9Iko7p3AIyPVUgIdnyO
         GPKSIbVPGytGmNqlQxtiTlBALGX/oEza96NONz78n4LYIv9Ohd0PTpd1qgfjYldLPtj+
         u4gfKNaasRkmwKPWe73hg1Vdgn5RP0INSm+zDgTMIydi9/G1G5YngA1fnEauBEDYKRmc
         O92A==
X-Gm-Message-State: AAQBX9dE0hgA8XUrdnU4PDVIRFFAzXoWGk+BlAqKf7xo/+1djW5rjxAW
        aab91sCS3lWgNm2HxAPOry4Lbw==
X-Google-Smtp-Source: AKy350YeVTFwjChuvWXMDPfn9hdUvuszJ5dCy+lMF7B/vMF+f7WGsj2RPKavQHMsOMV8lUKEmicf3g==
X-Received: by 2002:a17:902:e881:b0:1a6:7b92:15c2 with SMTP id w1-20020a170902e88100b001a67b9215c2mr2783582plg.4.1681475537517;
        Fri, 14 Apr 2023 05:32:17 -0700 (PDT)
Received: from [192.168.4.201] (cpe-72-132-29-68.dc.res.rr.com. [72.132.29.68])
        by smtp.gmail.com with ESMTPSA id j11-20020a17090a2a8b00b00244938da9b9sm2836717pjd.31.2023.04.14.05.32.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 05:32:17 -0700 (PDT)
Message-ID: <bfc01a2e-6285-fb41-c1e9-e6c37b61722d@kernel.dk>
Date:   Fri, 14 Apr 2023 06:32:16 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] nvme updates for Linux 6.4
Content-Language: en-US
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <ZDjjF9NWdq+gC0tI@infradead.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZDjjF9NWdq+gC0tI@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/23 11:22 PM, Christoph Hellwig wrote:
> The following changes since commit d8898ee50edecacdf0141f26fd90acf43d7e9cd7:
> 
>   s390/dasd: fix hanging blockdevice after request requeue (2023-04-11 19:53:08 -0600)
> 
> are available in the Git repository at:
> 
>   git://git.infradead.org/nvme.git tags/nvme-6.4-2023-04-14

Pulled, thanks.

-- 
Jens Axboe


