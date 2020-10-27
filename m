Return-Path: <SRS0=+SaT=EC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E6E3C55179
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 18:11:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3FD2076D
	for <linux-block@archiver.kernel.org>; Tue, 27 Oct 2020 18:11:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda-com.20150623.gappssmtp.com header.i=@toxicpanda-com.20150623.gappssmtp.com header.b="z4qApQkf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1825575AbgJ0SLc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Oct 2020 14:11:32 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:39152 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1825420AbgJ0SLC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Oct 2020 14:11:02 -0400
Received: by mail-qt1-f196.google.com with SMTP id i7so1698993qti.6
        for <linux-block@vger.kernel.org>; Tue, 27 Oct 2020 11:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=/dpwqPuJKVc4PuSdGfhLa6ddfo/1kSUn/kVHSfMrWNQ=;
        b=z4qApQkflA4Zvage2l4skqB/aYmQNJ+ILyDeWcbIffpgM38Z3/euK5CCLUZ+gJoqFW
         zFIcjbVPUNqetEz59BouZ4JTfvu93GTVBkL8RIuJ2uoHprcwxJVNWqt3kDX+tY+KnHNw
         1dvLz7PtTJIYBRx/RvfRJD5iQSRhMhN+jvSYRqXKYegYRxBpK3VBWXY1yLxThecpyYzk
         qSlIFotCQJTFFEvCdY0IecCuX5oYwN3IPrkHTQB96JyvlPSGf3TMAq3ZVjD8XGS8KAQo
         DBUh5jexsNwwu6etuNggJDt1BN8iVePsiGNfAi+KYPcWkX6BRjyZkf4ajfhjBNPSip0X
         Vnrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=/dpwqPuJKVc4PuSdGfhLa6ddfo/1kSUn/kVHSfMrWNQ=;
        b=EkD+8lXzXUOby8I0+f+1Uo73VwszsVI9/AdK/IfVOlm5Xtg9D/O4/6n7/yHlqBaits
         STLnMt3xSVl2vklIX33pbNLr10IY4v0LZoQYPMm/m7jwtgptRqUJdrHZB3XBMmKVHdsM
         Mcdz6flm1hS21r3eUJBYKsUb4z1vfDWtFvNOjcnEkrrvbTr1oD6/zfIeHP4YX2m7Gv/i
         VnIZfcYDXVDHlGdQkSS+JLWn4iQ0o3CuAP49dXwlJ1FG8OYxRPMKtvv83hK6xiRRAbA6
         ObfO+P5JMFMEFaBvoIRTunP0fgNC+hsBvsICR4SKRoXi+ahxi0EkvhCnpMZV1qTpdN5I
         l1Ew==
X-Gm-Message-State: AOAM531b5ri+lHNQfI2zR3mptbBMeYSX4BMcInYCgw2aUuy4aJy3Q/UH
        Xzan8pFHt+TN8Qp9Lp57Fu8Y2yqsT3+7JSKC
X-Google-Smtp-Source: ABdhPJyD6rYmpEwDZjRbmHthki4s/f3ww3q4WEkDV2z83ZzS4JkYq5EscyWBc8YBsGtjKpeAdGKpsA==
X-Received: by 2002:ac8:3a64:: with SMTP id w91mr3443174qte.86.1603822261170;
        Tue, 27 Oct 2020 11:11:01 -0700 (PDT)
Received: from [192.168.1.45] (cpe-174-109-172-136.nc.res.rr.com. [174.109.172.136])
        by smtp.gmail.com with ESMTPSA id c12sm1339419qtp.14.2020.10.27.11.11.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Oct 2020 11:11:00 -0700 (PDT)
Subject: Re: [PATCH RFC 2/7] block: export part_stat_read_inflight
To:     Anand Jain <anand.jain@oracle.com>, linux-btrfs@vger.kernel.org
Cc:     linux-block@vger.kernel.org
References: <cover.1603751876.git.anand.jain@oracle.com>
 <187d1f02f82019d48f66c97c0d1b99c9a58cd553.1603751876.git.anand.jain@oracle.com>
From:   Josef Bacik <josef@toxicpanda.com>
Message-ID: <7e98c923-d484-d05e-b5de-4eb85114ba4d@toxicpanda.com>
Date:   Tue, 27 Oct 2020 14:10:59 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <187d1f02f82019d48f66c97c0d1b99c9a58cd553.1603751876.git.anand.jain@oracle.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/26/20 7:55 PM, Anand Jain wrote:
> The exported function part_in_flight() returns commands in-flight in the
> given block device.
> 
> Cc: linux-block@vger.kernel.org
> Signed-off-by: Anand Jain <anand.jain@oracle.com>

This is much more internal to block and I'd rather not rely on it, I feel like 
getting the average latency is good enough.  Thanks,

Josef
