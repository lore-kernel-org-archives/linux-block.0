Return-Path: <SRS0=5ZWj=WP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDA96C3A5A0
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 14:56:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 833472082A
	for <linux-block@archiver.kernel.org>; Mon, 19 Aug 2019 14:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="lEc1sJYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfHSO4I (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Aug 2019 10:56:08 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:43036 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725536AbfHSO4H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Aug 2019 10:56:07 -0400
Received: by mail-io1-f68.google.com with SMTP id 18so4870287ioe.10
        for <linux-block@vger.kernel.org>; Mon, 19 Aug 2019 07:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=o96QziCz5cSc1akTWVLM60+viCalKfViDK3HHrpSFkg=;
        b=lEc1sJYiUq93aSWwV1B6w0xJMpvVnuwcQkrzoN4nYsB7YUes/vJ+mRrIImUREHHFgS
         oei96E3Zp671HxY/vWkV/RXYzWXJ6i4ApixSAf5gZ9+uA2dhlPDUTa6RnLWEHejkCxdx
         QJO33LgMk2+6aoFpBEdYwEpgPleUtWCe7W+RIqFn4XP+HfP6wHmM3jPMqiK7tkHkMSp+
         I/RMwjdVS4JfWRNApGNWaH+FRUrz8ZcADo5iK3YlXxX5VoLYi4YVQvs/ljrFxmhn5tU7
         v/k4rknCmh0dxxrbeXRP6hA4HNqgYQUqqYQke3KltxgDlowp9jcct40DuF0qLsm1nuNl
         DvJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o96QziCz5cSc1akTWVLM60+viCalKfViDK3HHrpSFkg=;
        b=JOgxV+f6ij6WTw9M4t3ie14+na8tP5QyZPgG6r1eP4Hn6fXiQW1UNEzOYMcANwYLvl
         VI2I7HS2b3ShMLqhvx8rdhh206JaPKhTO2B1f+vAFaRriPLafjTlKZUSfUaLxMQVYxrc
         kZUqeSdqX+RyQkOiwJOaeDWIJoeWvyHkLw0sUvXRlC3hge9KKhX3WoywNHHsMMrgs+r1
         v/pKYkJ1eJK+HmKB4KMJFJ74x8cZ5sMRMcUthOitVB8sb8jsSxq4xGfxoc9gfei2qK12
         BoGKAFjuIatkm2r5eHC97j8QkHTPF4NUJxmciRZtbWM91y/gbywBDbuT4282P7W1IuZg
         btow==
X-Gm-Message-State: APjAAAWdd7raSwIZb0QiTpF5xQGDHekWq6JfikGioibWoyNZMArpkKr/
        vTnnFYf24vUQPxQ1cebOtwFZoS66edbpmA==
X-Google-Smtp-Source: APXvYqx7H5svKaGhpQOSgLP0xRUtOVgsqmPdnPIzQfJYVO7VhuvOvnq0vq+xedFXlN4lGHhQWNwhaQ==
X-Received: by 2002:a02:4881:: with SMTP id p123mr27819524jaa.69.1566226566728;
        Mon, 19 Aug 2019 07:56:06 -0700 (PDT)
Received: from ?IPv6:2603:3026:406:3000:70aa:6052:7aba:c7b? ([2603:3026:406:3000:70aa:6052:7aba:c7b])
        by smtp.gmail.com with ESMTPSA id a1sm10841726ioo.5.2019.08.19.07.56.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 19 Aug 2019 07:56:05 -0700 (PDT)
Subject: Re: [PATCH] block: remove queue_head
To:     Junxiao Bi <junxiao.bi@oracle.com>, linux-block@vger.kernel.org
References: <20190816211233.22414-1-junxiao.bi@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b2b507f3-5e59-8906-3e21-a01bfe1da1b2@kernel.dk>
Date:   Mon, 19 Aug 2019 08:56:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190816211233.22414-1-junxiao.bi@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 8/16/19 3:12 PM, Junxiao Bi wrote:
> The dispatch list was not used any more as lagency block gone.

Thanks, applied with the subject/body rewritten somewhat.

-- 
Jens Axboe

