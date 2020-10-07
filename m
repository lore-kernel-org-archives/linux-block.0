Return-Path: <SRS0=w7gf=DO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D84FEC4363D
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 13:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F5AB20870
	for <linux-block@archiver.kernel.org>; Wed,  7 Oct 2020 13:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="N0k+2Vf1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728544AbgJGNyr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Oct 2020 09:54:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728177AbgJGNyr (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Oct 2020 09:54:47 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD0FC0613D6
        for <linux-block@vger.kernel.org>; Wed,  7 Oct 2020 06:54:47 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id c5so2318911ilr.9
        for <linux-block@vger.kernel.org>; Wed, 07 Oct 2020 06:54:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5xAx6y/5JiRXXWgVy0lo34k9ty9yQYwEFzj7BXHXi9E=;
        b=N0k+2Vf1KRg7F764OkadTiRVqCP/E0lZMZa38Y3lvF6gPfQ7CjVM2IaIn3uIOaOR0a
         Qob5yjt74dyUkm4tU3wuBCT7K0xn4nys6S8FJP9T6WmKnwb3XuFaFH06Qj9Nlu90ETcc
         HoGSNhuAQfZBKct7tqTNrm5OvyCdjnVWsM+EM530xWstuRRB7aATYOdVuqS6aIAoGTBw
         xytlhBpvHANXidMLH3BIKzvKuflPnATGE7TlfQf3751MXKWFkNpo9dJ85RSohIa1UYr5
         OxW/k8OUWr7GHdTCYg2w1HZz4KO5MQ69uBFTWiVPWZoGO5bUkzVhjdmNXK3QsgjYn8vd
         581A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5xAx6y/5JiRXXWgVy0lo34k9ty9yQYwEFzj7BXHXi9E=;
        b=hlThmU8tmI+7uC1D0vgaKrEUAjXVspO/a4+/qfXKviYw//BvX8Dwkx+9lrpUk3aPCQ
         Dpt71369M/QivdExjivr6v6Eqjx6kpeKxItpr7tb73wQkPegIp+QSAz42GQgAsS4chVe
         4rPgDbJ4nzeOFXcqQLufodpQBP5DjDvu0GdkLozVpEKUB/RQi7NUrx1DJvFyQ9JdjljD
         /OgSXVZiJ2tW7mLpnZe86GzOA/QBFHR2M0AOgYILTOVMTMTMoxvNXA8+naxXz8YdUIgl
         z58XyC7Wmm3dPgDcmBBvvpHSECqn4JZqtDzV+QJ15ateKHQ1xhlNDlVWR5hkvwKbjEu+
         g29w==
X-Gm-Message-State: AOAM533NcpI1McDnQrfx+TbbX/Uq2QQ6Hj9V4CADbcmt3Nw3mzK46z3M
        tB3ttQG+UMguvU6Uo64+GTmKZg==
X-Google-Smtp-Source: ABdhPJwgrdZEMJp/c+cibVOjieUYh6JNQXgQNaNFuHR7uafgCzt5iLnmPkRzSHm5s+LsyJVaTjkwGQ==
X-Received: by 2002:a05:6e02:ea7:: with SMTP id u7mr2896251ilj.175.1602078886276;
        Wed, 07 Oct 2020 06:54:46 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id t26sm890685ioi.11.2020.10.07.06.54.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2020 06:54:45 -0700 (PDT)
Subject: Re: [PATCH] partitions/ibm: fix non-DASD devices
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-block@vger.kernel.org, sth@linux.ibm.com,
        linux-s390@vger.kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>
References: <20201007124009.1438269-1-hch@lst.de>
 <a8b1c076-c280-d201-8403-2392a42d2163@kernel.dk>
 <20201007135411.GA1000@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <874c518d-7c15-d08a-61a2-116f605c4b5a@kernel.dk>
Date:   Wed, 7 Oct 2020 07:54:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201007135411.GA1000@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 10/7/20 7:54 AM, Christoph Hellwig wrote:
> On Wed, Oct 07, 2020 at 07:53:27AM -0600, Jens Axboe wrote:
>> On 10/7/20 6:40 AM, Christoph Hellwig wrote:
>>> Don't error out if the dasd_biodasdinfo symbol is not available.
>>
>> Should this be marked for 5.8-stable?
> 
> The Fixes tag should automatically take care of that.

Not if it's not marked for stable. Maybe auto-selection will pick it
up, but it's not a given.


-- 
Jens Axboe

