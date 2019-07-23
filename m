Return-Path: <SRS0=ppXp=VU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 900E0C7618F
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 02:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 630CC2238B
	for <linux-block@archiver.kernel.org>; Tue, 23 Jul 2019 02:17:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IfZRMZTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726803AbfGWCRy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 22:17:54 -0400
Received: from mail-pg1-f193.google.com ([209.85.215.193]:33510 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726567AbfGWCRy (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 22:17:54 -0400
Received: by mail-pg1-f193.google.com with SMTP id f20so9343976pgj.0
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 19:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=t/xh5wSawJ8Oerj64U5J6wYsxSNAL6y2p2sEZVqs5go=;
        b=IfZRMZTsh/dfz0ij8J6Xk1sdYcSgAGVi+h9p9Kwy9LLw6csjKuZBs4uYH7auR1JFq3
         sQ9tY4RVJMkg1Kzg6iiZ2PazBWVr7XxwEEcHF+cdqYP0tMAeEvhlMyl37sDbiBVsPtjE
         f7d+hdp2lvNN+0yi+Z7ucZ5TlPNRabobgBKKE7cNw+OhyAS9WjAXW97jpttU6SG6i0C+
         x9jjx4WNa5g+xRyYlSaJttbBhMoUvTGKcNpRT8w9MayqoiB8mp1hBrHJIU2uTYbMe7bg
         rYBcZOZugmQYlRFWNCDGBbD6yrfzKTXlOhsGWb/nhMBJR5SMKij1TJGMilwdzRN1LonM
         Etug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t/xh5wSawJ8Oerj64U5J6wYsxSNAL6y2p2sEZVqs5go=;
        b=rd0wlkGfXDs0N8qn2wOHN2JvBunzmVPur0D27se6CExJ3ohOFGQoVJNHrUlpSzLLl4
         erE+4XtvhNO7VXLost2W93trrywq5iUI4YsfgNv6Do1M2M4xrWKIPks9jg5z161heRz0
         d48Vi912SoSUp5X8L6feLCVxRgfX4Jlw6E6MAt2Q7rG+MQUmXs4YaEwV+raR5G5ynZI3
         DFsKjIlAiiY90NEkoQE995Mr4anbA3iZuTOFVIJBoOvuQEbU9dYKC86j9BklsDnrI1Xe
         3y+OvQLAufxj+vyfT/ofZKWu0/pQyCPiUDHULGEF5Bx2g8DDwqUoQtb7nk/WVLsxaMUi
         0ekA==
X-Gm-Message-State: APjAAAWwwLJLaAFQNxk0PdiMP+s9WXPv9/bApdU3QZ1QQygFk2OSw9DR
        7QduwxJoHgATuFnWunKwEyY=
X-Google-Smtp-Source: APXvYqxzOqKV9kQ6Gsm9HpHqCzeUQSF9Zh0C+EW4GeY0aM73DCnJ0bnJnlg4L3ArDGLMaSKHlxhPaQ==
X-Received: by 2002:aa7:8b11:: with SMTP id f17mr3286688pfd.19.1563848273863;
        Mon, 22 Jul 2019 19:17:53 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id u23sm41544350pfn.140.2019.07.22.19.17.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Jul 2019 19:17:52 -0700 (PDT)
Subject: Re: [PATCH 0/2] Remove blk_mq_sched_started_request function
To:     Marcos Paulo de Souza <marcos.souza.org@gmail.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        hare@suse.com
References: <20190723021439.8419-1-marcos.souza.org@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <864e671d-06ba-9689-9caa-8435cde1c860@kernel.dk>
Date:   Mon, 22 Jul 2019 20:17:51 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723021439.8419-1-marcos.souza.org@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/22/19 8:14 PM, Marcos Paulo de Souza wrote:
> While inspecting the queue_rq calling sites, I verified that
> blk_mq_start_request calls blk_mq_sched_started_request, and this function
> checks if the elevator of the current request implements the started_request,
> but currently none of the available IO schedulers do.
> 
> So, let's remove blk_mq_sched_started_request along with started_request, which
> is member of the elevator_mq_ops struct.

Looks fine to me as it's unused, but please fold the two patches. Makes no
sense to split that into two separate patches.

-- 
Jens Axboe

