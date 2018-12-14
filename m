Return-Path: <SRS0=oQb0=OX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60A49C43387
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 16:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0BA23206BA
	for <linux-block@archiver.kernel.org>; Fri, 14 Dec 2018 16:52:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zTR8aX2D"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729660AbeLNQwt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Dec 2018 11:52:49 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:43206 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729409AbeLNQwt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Dec 2018 11:52:49 -0500
Received: by mail-io1-f65.google.com with SMTP id l3so4913465ioc.10
        for <linux-block@vger.kernel.org>; Fri, 14 Dec 2018 08:52:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=stNGnhwgpuFn5kMiqPF3gZKKIBOCJtTy1ruQwY4Qh4w=;
        b=zTR8aX2D2Ph2dbmF7onVXn7BBe6/lV6ct+GupTPVnh44OIYBPeE0PoBTEnhYxG2hsR
         pxMaWbaPYBHuB4tlxd5ZV4bBFS8USQF0uve2Znrgwi0MaMHUBpdcjPEL3Jmx1Fk4vf6j
         yEeNapZTSTy+v7EdePaYJpZaYOKZ+7kXw5Paq3kUaObkja2R0Ho0cymu8U/wcp3lRsgR
         LrO00HLS8ErThMp1X8NoYJ6T3IfVYWZ6LykzdfJeSyLpVU01OJrIFLSLOJI1zyyXu58O
         8dkUC/p5csWfjMzxkSgbSWKjF+e6Zc+0WZIkG+kT4rq0ss0MZsmtO7UJYrnmjIED9lNa
         q6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=stNGnhwgpuFn5kMiqPF3gZKKIBOCJtTy1ruQwY4Qh4w=;
        b=LFRxTL3ctkHaFW4tqfu1wKfPgyv6Nl4mFM+c/B+qJn2SoJe99Lhoux7Oz8UU/7cCCT
         JRrm6W6LLugENOK4jpqJmsyLsqde1/H6WwUMydcAI0R7CkI30BZvdvu77eUvBdkHZTMu
         6CEuAovHliEc8cxKtJTpcDqk7EYcllDxkP/mAEbJOM9ViIdL2QGkEUvj9Jgiw4gi6M+e
         1kTRbkCsbKZ3AOwjQqV/9o3U2Ty09VkfZ6PpgPStthYwP2TlEagW3hm1T8Tmm6hUHa51
         GOfIGODlyHVGMBY/2lNckbVSg8p6MojRK3iSA/SgmAKzagBdqB96hLvCjmjukYnw/E20
         GN+Q==
X-Gm-Message-State: AA+aEWYBREFy7bRTCPVjpflnrvDZnibZBLk+OfGvgugPkc08THJ35k5b
        NbS+udyQPTQjBB8jRk5jAM70iw==
X-Google-Smtp-Source: AFSGD/XaqfsM71QH817iYqRNw1vAkpsDn5pbVlQVi2TgYlTnHQcOhGOKU0ZxIT3hPeBOLIgbhOdm/w==
X-Received: by 2002:a6b:156:: with SMTP id 83mr3073488iob.63.1544806368446;
        Fri, 14 Dec 2018 08:52:48 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id c102sm2864383itd.38.2018.12.14.08.52.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 14 Dec 2018 08:52:47 -0800 (PST)
Subject: Re: [PATCH v3 2/6] block: make request_to_qc_t public
To:     Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, linux-rdma@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        Keith Busch <keith.busch@intel.com>
References: <20181213213410.9841-1-sagi@grimberg.me>
 <20181213213410.9841-3-sagi@grimberg.me>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <81f1587c-a8e0-8b6d-5cab-c6b2a6fff276@kernel.dk>
Date:   Fri, 14 Dec 2018 09:52:46 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181213213410.9841-3-sagi@grimberg.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/13/18 2:34 PM, Sagi Grimberg wrote:
> block consumers will need it for polling requests that
> are sent with blk_execute_rq_nowait. Also, get rid of
> blk_tag_to_qc_t and open-code it instead.

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

