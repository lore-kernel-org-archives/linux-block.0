Return-Path: <SRS0=KrPA=UR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70861C31E5B
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 19:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 39BC820679
	for <linux-block@archiver.kernel.org>; Tue, 18 Jun 2019 19:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Hz7fj+ee"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfFRT7G (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 18 Jun 2019 15:59:06 -0400
Received: from mail-ed1-f67.google.com ([209.85.208.67]:40277 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730189AbfFRT7G (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Jun 2019 15:59:06 -0400
Received: by mail-ed1-f67.google.com with SMTP id k8so23447738eds.7
        for <linux-block@vger.kernel.org>; Tue, 18 Jun 2019 12:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sQSgJAjLDUfYJVN8p2nmbHNvJ620shYzyizmv3V8JUU=;
        b=Hz7fj+eeUk5M4wxw4x1+p77GKbpGLx3JyJIG8OUg1r90i00LVelAL9n6PXAVmd3R+M
         7GeRMtNqRnwoQKxGZDjEPFcdQC4570Sm+PiD8R79Q7ry6RTOZK5iMW6vFPt6cuR+wwB3
         ESH/yBS++ej1r78E4RO2vV6qiMux8w5vBU6n0BeVprwuFxI7Jq87sL/oDgFBL1/Iud1+
         8JLdq7WauQRClNk97GTF7ThHQq/K57i/P0ad9ih/7idH5NAeGyi4YYyaanap1cqsJDIx
         0/67J3HVQ/qQ8DiATFBuOvdOjqvI9kptXhsk3YwQ218UpyP3V17Y1o6vGrCYdzCvj6Ze
         4csA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sQSgJAjLDUfYJVN8p2nmbHNvJ620shYzyizmv3V8JUU=;
        b=dmksCmN5u3O6f3oPjnwA0no0wO3JjvqdNclHGwLMzw1bnbx+m7Am6Q+l0tc7LF9gHM
         goFOR3vqNwH7z92yyMVjzl/Eaz0MznLpbFli7CasgfD57AjBg6KYc24uRbbkgHX1olBt
         P+RDKH6KDFgilOTkc39cSrn+pc2m1J4tAbrZt7hXmRZRpTWcOqL3yFUi0vrvvFmc6IUX
         0rNrPxwDQ8BWgWeyXhF4RiQ6rznrbtqKtvvr5OVlcdb7NqMOgdZ/2B+BpUzkqhFHS5vT
         +qzGBVEEVakciurOXa3tcv4J2FYMSrd32SUKrLGj/uQLjuh9at6/tBL6vP58JTBuNF34
         af7A==
X-Gm-Message-State: APjAAAWq1X4h08wYUPcmomu4jBYq2Xe9ltqk8arOespoSVEdN2eXoM4C
        WuKydoDxnXKVGaMqgeD46bb9cgExvAMLJpvo
X-Google-Smtp-Source: APXvYqzdtIP/ZzxxJ+541H7ZPhjoD7PDBf2h/dIDP7K8BvafUUrmOFD9+siKP6OgGEYIILG3FVx48Q==
X-Received: by 2002:a50:9116:: with SMTP id e22mr94145395eda.161.1560887944715;
        Tue, 18 Jun 2019 12:59:04 -0700 (PDT)
Received: from [192.168.0.115] (xd520f250.cust.hiper.dk. [213.32.242.80])
        by smtp.gmail.com with ESMTPSA id x21sm2914652edb.0.2019.06.18.12.59.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 18 Jun 2019 12:59:04 -0700 (PDT)
Subject: Re: same page merging leak fix v4
To:     Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Cc:     David Gibson <david@gibson.dropbear.id.au>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        linux-block@vger.kernel.org, linux-xfs@vger.kernel.org
References: <20190617091412.15923-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <35950338-41e9-447c-d534-de735d5ffca5@kernel.dk>
Date:   Tue, 18 Jun 2019 13:59:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190617091412.15923-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 6/17/19 3:14 AM, Christoph Hellwig wrote:
> Hi Jens, hi Ming,
> 
> this is the tested and split version of what I think is the better
> fix for the get_user_pages page leak, as it leaves the intelligence
> in the callers instead of in bio_try_to_merge_page.

Applied, thanks.

-- 
Jens Axboe

