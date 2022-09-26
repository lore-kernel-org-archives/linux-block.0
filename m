Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5BB5C07E9D
	for <linux-block@archiver.kernel.org>; Mon, 26 Sep 2022 20:57:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbiIZU5C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Sep 2022 16:57:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbiIZU5A (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2022 16:57:00 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FE6647EB
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 13:56:59 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso8132122pjd.4
        for <linux-block@vger.kernel.org>; Mon, 26 Sep 2022 13:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=yL/tTcZXG3+VCa4EjF9fEyMfVEBTAHEkiOuokSh0vaY=;
        b=e2EmQhWTg25tqAH6SrAfTQ3fUKOkBbZxTSSlr8+KFL485N4Jz1sksYCPSaC4eOBwWJ
         jC9A+obK0ajYCGd9O6a8OHWaEXSWA6Bk3ItlBr5OPfFbmeU0P62r3X5SSvKOej7JACxb
         LcFS7NWqEjw6kZRUaIzVJnd1fQUTSA7x+3hg8Hosq4iayiq40fYijpQRi9jIzleKZJ1b
         LHAKZjDdkAV6eL4u0fIxogh6XtWMPibY++poUx68ktgOIoPGfDdA9sVO7HZtFwn+3/ZA
         JIcWqQdrYuQE8/EEAAp5uZWNaohA4DCRU/oHuDWnZvWs1K8k0OjMbBOGw2TozsQirq6v
         LKsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=yL/tTcZXG3+VCa4EjF9fEyMfVEBTAHEkiOuokSh0vaY=;
        b=XpTmcVodGKbdlVaRLebiDCkcn5ITIBhKkDuQzz0GEly3O5aj5kP8HdG21biDGMMMw4
         Y3K2oS7rUbZYFzMJrql+FtBKsdgr8QZIDYQl6sDYHqM7mvOphNNzbaMjhc6LEHFpcyTL
         qGqrhaagNCbozKWxH6x/WiD2UHi3Sj7oDf81Oa64/ZauSzo7uH4xgv7DR4HuELqG4f5L
         2VcwZxxykufAGFb6K9hv1fkrX0IsIE+ESc3MXN+fE8XgvFdrsTtbuqPqM9JRTXNq4NTV
         5UmiCGfpROje0vyqGMRz7A2iYR247CHzhadQqECYJ1XybsbTbR6AqhTIZyawI5BZ3hGf
         MKMA==
X-Gm-Message-State: ACrzQf1eG3fG1DA1Yz5lDZVr3ces9AQktVYUv0gDnavdV0eeKxDZVXfT
        KuqdH2/s6WUCaHZo4esdbmgvrHsIT1xljg==
X-Google-Smtp-Source: AMsMyM5Bm3IxnLWefgHHEiSiqBGoNysFNRfDjRhgTp13f/Iy1UHXB0iBjkLyLJLBTMILHQAaRTc8AQ==
X-Received: by 2002:a17:90b:30d0:b0:200:22a4:bfcf with SMTP id hi16-20020a17090b30d000b0020022a4bfcfmr649867pjb.181.1664225818893;
        Mon, 26 Sep 2022 13:56:58 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:a7e])
        by smtp.gmail.com with ESMTPSA id q29-20020aa7961d000000b00537e1b30793sm12876485pfg.11.2022.09.26.13.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:56:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 26 Sep 2022 10:56:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: Re: [PATCH 03/17] blk-cgroup: remove open coded blkg_lookup instances
Message-ID: <YzISGEz6wgOFQkkl@slm.duckdns.org>
References: <20220921180501.1539876-1-hch@lst.de>
 <20220921180501.1539876-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220921180501.1539876-4-hch@lst.de>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Wed, Sep 21, 2022 at 08:04:47PM +0200, Christoph Hellwig wrote:
> Use blkg_lookup instead of open coding it.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

For patches 1-3:

 Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
