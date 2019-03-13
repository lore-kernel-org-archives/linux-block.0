Return-Path: <SRS0=zSf2=RQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A263C43381
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 18:06:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED3B421019
	for <linux-block@archiver.kernel.org>; Wed, 13 Mar 2019 18:06:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ixVvOOu5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726485AbfCMSGU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Mar 2019 14:06:20 -0400
Received: from mail-it1-f171.google.com ([209.85.166.171]:37536 "EHLO
        mail-it1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbfCMSGU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Mar 2019 14:06:20 -0400
Received: by mail-it1-f171.google.com with SMTP id z124so332928itc.2
        for <linux-block@vger.kernel.org>; Wed, 13 Mar 2019 11:06:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=oytLyobtM9SwvBnmpS6I3oqCa8MewNWk1wIIy1gT2wY=;
        b=ixVvOOu5KNxAi70nVtaedsw6Bwb4KWjpbKz3zMuO2/GKZjayeDE8N6noYNzKhYyUqS
         E/3WW+1M2AE+M1ByhT9pNAyhDVoCMOnEeqOQ/LAvGeTqOtOP2nOalp6z3h+EYHXPKMWn
         VSNErO3Vz5Mbad+mMDV36hV7zg90R58l/ritsISMOkBYbQ/3Ggl9xL3tLrhvmd/GqVfd
         k9Lptg7Y3XlEUJaBZwwe6WFE8npIqZ4gOtHKG8K7er1jDiMmjPp+gGFuS7JYlPEdvQUt
         yzvhPuYaf9p8aMkTSbfG6jEJULzElKIA3QNE4jYjE8XY7gThehPymh2ChLbh7woyzXiF
         /aTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=oytLyobtM9SwvBnmpS6I3oqCa8MewNWk1wIIy1gT2wY=;
        b=Y0YqsxwtAjbY7K/j3A88ZPOdBs/yUZuNSr0Q888RlH5jjPEr36tv4gK4Qw0gWLhIpS
         WTG4MuSButZFoi3Ms2hrk4NHFuGcWntuP3jC96Vbh4+w/j0F2uqUpm2kZa9PLOZ5uZHx
         YBpohH4Ahgj/JvSuKB+z7jigXVX4qmOpk8oyge9ATcoFHpwSbJh8ziPeQDA5DkqR95Do
         VX82ZthgvjaaK6qewzubS9n7WJwpxJSJPC4T98d/oTflZgBdAS/cT64WCOXzJ3GzNs7B
         9EzeipPQqDQpw5SVjMeNCBF+HlnnwqAXzm/ca8pLo+xThti5+3p+zekLjHMr0L8+y3yW
         b8Fg==
X-Gm-Message-State: APjAAAV7T4m0bsSz1bA3DfD7umK3LxjueUMGuzCRq6RZ7WMPfBVi+skP
        zGf7lLDIyZMxZuJ2Y6yFGQkkNvIMZLbJfA==
X-Google-Smtp-Source: APXvYqzZu3sosJZxdlssaU0wBW66waPhHntDawhdPs3gu4l9U9PzqXUfXxX6TusXhKhvccumwOWjeQ==
X-Received: by 2002:a24:260d:: with SMTP id v13mr2476819itv.148.1552500378779;
        Wed, 13 Mar 2019 11:06:18 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id l8sm1527635itl.26.2019.03.13.11.06.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 13 Mar 2019 11:06:17 -0700 (PDT)
Subject: Re: [PATCHBOMB] nvme fixes for 5.1
To:     Christoph Hellwig <hch@lst.de>
Cc:     Keith Busch <keith.busch@intel.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-block@vger.kernel.org
References: <20190313175510.20725-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <ea9bce39-20aa-d8ba-4f0c-8fbd05839d0f@kernel.dk>
Date:   Wed, 13 Mar 2019 12:06:16 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.1
MIME-Version: 1.0
In-Reply-To: <20190313175510.20725-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 3/13/19 11:54 AM, Christoph Hellwig wrote:
> Hi Jens,
> 
> git.infradead.org seems to have some hickups at the moment, so
> this bunch of nvme fixes will come in form of a patchbomb instead.
> 
> Most important is quirking Write Zeroes on qemu, as the implementation
> there is buggy and could lead to ext4 data corruption.  Except for
> that we have various other fixes all over the place.

Applied, thanks.

-- 
Jens Axboe

