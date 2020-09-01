Return-Path: <SRS0=kheS=CK=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 221C6C433E7
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 17:46:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06BB72087D
	for <linux-block@archiver.kernel.org>; Tue,  1 Sep 2020 17:46:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="cXlpMLt/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728309AbgIARqF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 1 Sep 2020 13:46:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgIARqB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 1 Sep 2020 13:46:01 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BCC6C061244
        for <linux-block@vger.kernel.org>; Tue,  1 Sep 2020 10:46:01 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id f142so1767985qke.13
        for <linux-block@vger.kernel.org>; Tue, 01 Sep 2020 10:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=cSy4+2RDeeEJIAWSQYiuQheGRdiGJb8NlbxFbBqq2AM=;
        b=cXlpMLt/MZjGGJxxIXI3dRVI4uswoqGbuubaqPQro5E+Vxlidjbo5VD4YxUte9yV9n
         JGggD9c+n5hNtPF04P2fLwYCnLrn2PjcBNJ2TPdvwxby+LqAdjuTStUJWwXWsv7+VmVM
         5mRh+XQTeS1ZkGcYpcS2I2jsA3aNfqqxESdch/Lfa1suLKFyKj7pL/q/CaFoZCr613vh
         nMtVSMocVtIEc52WDjqw2OvCz5cwb6gn8KIGuZiEbNTm8mwhjITdAQNlXSR/HEbhcE/I
         OWouCb9f0F3A8GvtPJWlYO2AuTtiExzS5h17AM3EKMSVIiqlJsvrIIghN+G9eZ0GdcD3
         223Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cSy4+2RDeeEJIAWSQYiuQheGRdiGJb8NlbxFbBqq2AM=;
        b=rGrgQSVuWZ1ikc8TCFEeNCTbAsrpyFGmWMx9N3LwuDYKs8LKAekojt6awLebj3Y2ca
         AaHv/bV0MsZqNYd70KulBVyVL9Y+szlUuV2xXd2x+/NScmJmi8lr3dFr1Cy7tC+lslig
         vFFBLr4WIdnvnQiKeqihnbTt+0ruEEXWaaSLvxpuXVnIcPZ1gxBmyQQJDL7szscAncRe
         2x6MzrM2FUO5WGsBlnbF3AmR1vjYaMKupc2XFEdieomdF2EUo0h/hj8VSJHnjiMe3k98
         +9FQE4HdKl0pL2eWfK+V1BFzYOf8gXBBDgZav5+5qoKad+DllXWrQ1BSwWDy1BqOzWZi
         2GQA==
X-Gm-Message-State: AOAM533uSSIA4pWllQ8a9mQcbS97PvsG8V1SzAa/BQNppxfUPufI18+K
        wB6LgZPg22xypgERAxfFl42wPA==
X-Google-Smtp-Source: ABdhPJzuyOEEW4u0szMWmuV8qaZb9/osteZ8Kxw8co7ysE17hCNMDWr3cE6A6fD+O8okSgr6GveAkA==
X-Received: by 2002:a37:2d07:: with SMTP id t7mr2973895qkh.255.1598982360401;
        Tue, 01 Sep 2020 10:46:00 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id w20sm2217486qki.108.2020.09.01.10.45.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Sep 2020 10:45:59 -0700 (PDT)
Subject: Re: remove revalidate_disk()
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
Cc:     Dan Williams <dan.j.williams@intel.com>, dm-devel@redhat.com,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        nbd@other.debian.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-raid@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <20200901155748.2884-1-hch@lst.de>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <b89fe35d-cdf9-e652-2016-599d67bdc5eb@toxicpanda.com>
Date:   Tue, 1 Sep 2020 13:45:58 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <20200901155748.2884-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/1/20 11:57 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> this series removes the revalidate_disk() function, which has been a
> really odd duck in the last years.  The prime reason why most people
> use it is because it propagates a size change from the gendisk to
> the block_device structure.  But it also calls into the rather ill
> defined ->revalidate_disk method which is rather useless for the
> callers.  So this adds a new helper to just propagate the size, and
> cleans up all kinds of mess around this area.  Follow on patches
> will eventuall kill of ->revalidate_disk entirely, but ther are a lot
> more patches needed for that.
> 

I applied and built everything on Jens's for-next, patch #2 was fuzzy but it 
applied.

I checked through everything, the only thing that was strange to me is not 
calling revalidate_disk_size() in nvdimm, but since it's during attach you point 
out it doesn't matter.  You can add

Reviewed-by: Josef Bacik <josef@toxicpanda.com>

To the series, thanks,

Josef
