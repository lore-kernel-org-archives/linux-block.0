Return-Path: <SRS0=YK6u=OP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27DE2C04EB8
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:51:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E07C920989
	for <linux-block@archiver.kernel.org>; Thu,  6 Dec 2018 17:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="VIqjwJKw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E07C920989
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725871AbeLFRve (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Dec 2018 12:51:34 -0500
Received: from mail-io1-f46.google.com ([209.85.166.46]:42805 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725928AbeLFRvd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 6 Dec 2018 12:51:33 -0500
Received: by mail-io1-f46.google.com with SMTP id x6so1041512ioa.9
        for <linux-block@vger.kernel.org>; Thu, 06 Dec 2018 09:51:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=p+Rx8CLlS6c401nqoIEnCpIsNrBL9fyp9Oc6jt1Tq/4=;
        b=VIqjwJKw3smg1cWJh/wIPcBRMymm2SYM9WBebm5zk+ed2CV931tKYME84zMiLRDKnw
         2bch/XEgYWaAwrnUvIJ4ACQu78vbStAl5PQeTiMGqHsrrW+3Icq/XqrX+ifLa9z/1Dry
         dmebjcev4p0DY/xiKbvHYg3iEGLtvdztXo5TxJLxQOHD1gCdOJOKi2dcoJshkkWZvUPj
         Ry3FmLaAEv4UepKn8AcBCPHb0NpriDDy9+mW1puyYI+a6HFpyEtwXgTL7sDuLcmiHthf
         RDGwxEbKdn5My2vwCNdH/v7xnYPrV7W0na49tHoYwZgcFgy1fvM3F+E4OJB1vzG9jHFn
         /Z2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=p+Rx8CLlS6c401nqoIEnCpIsNrBL9fyp9Oc6jt1Tq/4=;
        b=Pj2Q5PkWOhsWeF7cXh5ylGARY++zZJFAnPE3CI7UbTACmXH29bUR205pw6Y27qj7kH
         qaKmaRKSoSRiExfyuvd5SYOBg/53ao9HBg4mU2j1ig8nQiho0ut7CPJTjs2JSoZPy8dc
         eqWt+QJ4fHIG2Nl2aYPjKbtEWfn2YwT0DMe9/uHZy5umaZk4hES6l9Byow6mEWttT+Mu
         5kMlqub4hJFF3HN5Zc68ZrB5wyxgHpsqdr2h/Bi0d3Hld43sgFDkNSj0NutH4zp5ocpw
         MragAo/jyl0mnQRMwKDj9ROTwzYym/ifHTCY7HLQdLR1GvT5600NDTEo4qwL1RiCnFN+
         4Pbw==
X-Gm-Message-State: AA+aEWZdD0MaMridXlJFBQaigcC5d+qqAo5r8SWAvDpn9HXM+PkqFtsA
        DNeTJdwvGicyGfBRsT9iwfVG7g==
X-Google-Smtp-Source: AFSGD/VhEVg4IpEMcqNRlzNeMlHtUoiv6smqrVQ6pAJ9+CnRVHj397rPiTCuEBptzrhB5P7bQmF78w==
X-Received: by 2002:a6b:c402:: with SMTP id y2mr1302259ioa.77.1544118693023;
        Thu, 06 Dec 2018 09:51:33 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w13sm692421itb.10.2018.12.06.09.51.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 06 Dec 2018 09:51:32 -0800 (PST)
Subject: Re: [PATCH] blkcg: put back rcu lock in blkcg_bio_issue_check()
To:     Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Josef Bacik <josef@toxicpanda.com>
Cc:     kernel-team@fb.com, linux-block@vger.kernel.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20181206174938.2326-1-dennis@kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <d179c449-9593-8630-2a01-8a625f2b7e67@kernel.dk>
Date:   Thu, 6 Dec 2018 10:51:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20181206174938.2326-1-dennis@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 12/6/18 10:49 AM, Dennis Zhou wrote:
> I was a little overzealous in removing the rcu_read_lock() call from
> blkcg_bio_issue_check() and it broke blk-throttle. Put it back.

Applied, thanks Dennis.

-- 
Jens Axboe

