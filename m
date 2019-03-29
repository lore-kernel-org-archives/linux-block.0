Return-Path: <SRS0=pPwc=SA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6106C4360F
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:20:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 73DCF2183F
	for <linux-block@archiver.kernel.org>; Fri, 29 Mar 2019 14:20:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="eZuUgWqk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729406AbfC2OUk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 29 Mar 2019 10:20:40 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:39843 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728652AbfC2OUj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 29 Mar 2019 10:20:39 -0400
Received: by mail-it1-f195.google.com with SMTP id 139so4092358ita.4
        for <linux-block@vger.kernel.org>; Fri, 29 Mar 2019 07:20:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=IJApajzilyrOBUOhH9z22ai+kPPbWGy6cgC7ap9X+vI=;
        b=eZuUgWqkZQSL2Vo0debRtiWr8TFBPe2vNFowm2pgGqry9GH+NDo3ZHyieHMIWlUr3T
         Mxvbya0d2qEedGmDcXubb/w9bE4e+yG225rJ591bk2jbJR241dZaYh6HFmuVSg/E1tgk
         IYPopXvtzjmVG1xVqgBw4eIo71W+WMQCOpTgctaG4T1DkYggrU4giAsHJI5tWB+17kSy
         QurNOZcC6upStfgYvw5bp7aCzN43zvry7YyY+vnrbzWdpHXZn63pJj1v2mnzouosZ8cN
         ECEHlOSuCiHAyNUJbVPDo2Ow+2gq5sDd+JCyF9eucqB5zC/elH3eGUvgnGqBeSH2rIfj
         FoRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IJApajzilyrOBUOhH9z22ai+kPPbWGy6cgC7ap9X+vI=;
        b=RKrrXlHjRL5nWs9Q+doJ+RIYmMw5HHCyMdPdRGbeWzXZLlM4cHDcVL1mDHzOUhS6gN
         ASnLgcEOWRchcqnv28TUkgtDpcc2ogO0KGOguak0lG0HrrbiuwQlLUmiy/19ANC+BLOK
         ESOT8N5uU+ybsHt3ZPhsjEaeO/3Pi4Qz/CP6NkFvWYrYBrM6F9hwEdOv9gLxx2NQcfo3
         9jFbEIprui6xt5hy/gDh8V2TLcf0YmwcnXUgtNN9/rgdpATuq1BJ4m1SLf/r3gAEQE9E
         d0EcIG8p4DdlT5bltFmVv6t/kZrlG2DfZUskEGmbiPkkUeQSW/VtkBkla+rl/r676kdM
         lKLg==
X-Gm-Message-State: APjAAAVvtLF7+QU7p6lEjnX26iU8XLiwoia/eyZb66qXz17DL+k7tTIt
        ihLDI38u0CG9hPGOvWty5aoUGzahxKoFSA==
X-Google-Smtp-Source: APXvYqxd4KyYltn6l1074MaxGI2M8IDimuUc7rbSckWWV+tZDuozdSB3xKNSFi+FrVkoLX28KI4m2Q==
X-Received: by 2002:a05:6638:258:: with SMTP id w24mr36990348jaq.85.1553869237750;
        Fri, 29 Mar 2019 07:20:37 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id a8sm852809iol.35.2019.03.29.07.20.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 29 Mar 2019 07:20:36 -0700 (PDT)
Subject: Re: [PATCH V3 00/10] block: enable multi-page bvec for passthrough IO
To:     Ming Lei <ming.lei@redhat.com>
Cc:     linux-block@vger.kernel.org
References: <20190329070803.10958-1-ming.lei@redhat.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ca3a4d22-ec5a-4300-3ff2-08e0c02ed3dd@kernel.dk>
Date:   Fri, 29 Mar 2019 08:20:35 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190329070803.10958-1-ming.lei@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/29/19 1:07 AM, Ming Lei wrote:
> Hi,
> 
> Now the whole IO stack is capable of handling multi-page bvec, and it has
> been enabled in the normal FS IO path. However, it isn't done for
> passthrough IO.
> 
> Without enabling multi-bvec for passthough IO, we won't go ahead for
> optimizing related IO paths, such as bvec merging, bio_add_pc_page
> simplification.
> 
> This patch enables multi-page bvec for passthrough IO. Turns out
> bio_add_pc_page() is simpliefied a lot, especially the physical segment
> number of passthrough bio is always same with bio.bi_vcnt. Also the
> bvec merging inside bio is killed.
> 
> blktests(block/029) is added for covering passthough IO path, and this
> patchset does pass the new block/029 test.
> 
> V3:
> 	- fix build warning on patch 1 and 7, only the two patches are
> 	  changed

Please just send me an incremental fix for those two patches, v2 has
been in my tree for a while now. I can rebase it since I haven't pushed
out, but doing so incrementally is a lot more convenient than replacing
the entire series.

-- 
Jens Axboe

