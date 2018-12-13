Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 997EAC67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 00:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5BEAF20851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 00:44:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="bT3XD8DT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BEAF20851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726381AbeLMAoC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 Dec 2018 19:44:02 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:35016 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726344AbeLMAoC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Dec 2018 19:44:02 -0500
Received: by mail-pg1-f194.google.com with SMTP id s198so171563pgs.2
        for <linux-block@vger.kernel.org>; Wed, 12 Dec 2018 16:44:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eGCL8CXk2DxsRI6RmIenE/gWHSpzzo3ICYl1Dkuy9FQ=;
        b=bT3XD8DTdeHNd1n7r1baIPUQ89GQKbMby4TiPYbrsR8kiaghg/YQFkWEgaHm+c2j9P
         1UlBC6u5KTkRSzIMxaI4/bTCiPyybRCDtR4h4F1NPUNNL21q6axIUJA8bVsJv7/hLPtL
         6IGHyRtjtkypXbam8yBKBp1wudltVrnCLUYqx2pWAFNP51kFRbgaFZm5dR5Ud64wBr4H
         F8vZlbH8atdbIjbB5oYO93hNDcMJtU96lpGvdkOpgzk6z062VLLiR9h2fbeZVgvt4fdd
         v25M1E6LcBI3mDeM6Sq5iG++4pXKEbNJfdUu0KAwhYxKQsp/d60f1PPPRUb6/IiUACCq
         ppig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eGCL8CXk2DxsRI6RmIenE/gWHSpzzo3ICYl1Dkuy9FQ=;
        b=Q2vpP8hE7ZWTwBwPW8FfetJpSrpVfHaTWs2pBMEMvvsAijUPkLcjJAydLHTSQyD5z/
         EhEGdSpZWic4bgANR+EFXkAmeU5Hpprh7uFPIIUktYzcZeurQxE/hlBXor5TO8vxCpzn
         0/XUIbxGs6EORrfrAT00rZ2WwJJZfZoQKUkR40jXKdKS0HbeNO5NFSg5XqUbLbXFBZbh
         K88w9YfnZX7refK+hp40jhslR1mpKL11vkVX/ltBZgaqrXVpJS16dglbrHeWVZ5isNt9
         OuvQOVZi9X8FrKb3JfmbP8sArDTwKO68G9exRnBo6Ne0MWnM29NX4zA0En60Sfj14o5Y
         ieiw==
X-Gm-Message-State: AA+aEWbzpEjH4w6eGKMyX0uEK9Cvymt6sJQR/v5Z3940GnCI2DAxOhor
        C0rFbDjwBWy8IXC2sis+bZYkTA==
X-Google-Smtp-Source: AFSGD/WKp5J5LeNaoqGKcG5fzCqad43ccyyu0EEVy1qkK/rSC3+B2UvfamPnuXjatcvsz4hgIrN1lQ==
X-Received: by 2002:a62:62c5:: with SMTP id w188mr22423342pfb.160.1544661841546;
        Wed, 12 Dec 2018 16:44:01 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id p2sm236938pfb.28.2018.12.12.16.43.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 Dec 2018 16:44:00 -0800 (PST)
Subject: Re: [PATCH] blkcg: handle dying request_queue when associating a blkg
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>
References: <20181211230308.66276-1-dennis@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <217c7b15-d54a-b51d-8b1a-c2ad0d404721@kernel.dk>
Date:   Wed, 12 Dec 2018 17:43:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181211230308.66276-1-dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/11/18 4:03 PM, Dennis Zhou wrote:
> Between v3 [1] and v4 [2] of the blkg association series, the
> association point moved from generic_make_request_checks(), which is
> called after the request enters the queue, to bio_set_dev(), which is when
> the bio is formed before submit_bio(). When the request_queue goes away,
> the blkgs supporting the request_queue are destroyed and then the
> q->root_blkg is set to %NULL.
> 
> This patch adds a %NULL check to blkg_tryget_closest() to prevent the
> NPE caused by the above. It also adds a guard to see if the
> request_queue is dying when creating a blkg to prevent creating a blkg
> for a dead request_queue.

Applied, thanks Dennis.

-- 
Jens Axboe

