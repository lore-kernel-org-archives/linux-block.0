Return-Path: <SRS0=bgcA=6B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45194C2D0EF
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 14:05:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2260321973
	for <linux-block@archiver.kernel.org>; Fri, 17 Apr 2020 14:05:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="cnzAd38S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731014AbgDQOFt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 17 Apr 2020 10:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731011AbgDQOFr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 17 Apr 2020 10:05:47 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F069C061A0F
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2020 07:05:46 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x26so1146557pgc.10
        for <linux-block@vger.kernel.org>; Fri, 17 Apr 2020 07:05:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=i1IMqZs1rCNg+Kakd6PCCsTWURNUZOM+kVoAEiJdagU=;
        b=cnzAd38SaoQ3yLyq48Cx+BL26/4L7SE5w/HKzAkiWJJVi1KXQWhPpnE0dHEBwjCFyu
         bFk37IMexjdV/NHqvSjHuW4j8l07gePSDMqodv06UHEj9hQCgIA8hBGowEbFcHPtyiuS
         neT83FS1KGhdwa6ZpHOhHz0s5ruLz6d5PMCP3YtnnOs/DGtWQeSRJv7naX/9H05iVXWF
         IB7ae0In9VxDQYVMRswbX1MZMa8+W+Be9uusMywbw2cmgH73gOcK3N1yZzOAd5xKvnKk
         cntnE2crWiiJAJT3TaP6cw+NJudMDwFZr9HR1y5xFOqfnU3BODr1Y1b7HHKmB+hnrq7E
         bq/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=i1IMqZs1rCNg+Kakd6PCCsTWURNUZOM+kVoAEiJdagU=;
        b=Wp2bAGJhhGkbWwB/srrWlOy7fQhDdUoehxOZjsogdXG7xL8lNHqqAndM7MfZ1BB8ST
         7Q1+IhObq8HIfgbJVCz8ABThOV4jARB+NLcCnkELWYSDMKTXATV/lqfvdA22pZJfXJPn
         JgPFavsMAFnXvBd8O85JfQxG1gibz5vRHm1n/cp0I1QQB9ducFJ373cfGHKpvgOvoqkL
         OAxrIV0OtPfp/Gjbc4FrIz0omYjH9b0qNMDy6OL7TWJqK8+g31CR7/CBETIhQD4ZbX/D
         jW1mDc9UQX5SNuWzE+AuC1mJAJfcHRqlRpqneC4exrdwDk5n+ZuCsohPDlI7vZVBDgH/
         VrrQ==
X-Gm-Message-State: AGi0Pua5hOzm8qY0jkSKRfBd+IhquUbNZ4hTpbDBVIzIRpms30QtZskY
        7fT7F+xQ1Xb4iMud5TKlQRlWAl+sozUjwQ==
X-Google-Smtp-Source: APiQypKFDdJJi0cffxPk+IgS4DQdL81dp2NOAuWFNFDAz31Fj+A/HtPaD9Cs1tHDmM4dZcx12zbU0Q==
X-Received: by 2002:a63:c34e:: with SMTP id e14mr3295875pgd.212.1587132345488;
        Fri, 17 Apr 2020 07:05:45 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.145])
        by smtp.gmail.com with ESMTPSA id jx1sm5812584pjb.5.2020.04.17.07.05.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Apr 2020 07:05:43 -0700 (PDT)
Subject: Re: [PATCH 1/1] s390/dasd: remove IOSCHED_DEADLINE from DASD Kconfig
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     linux-block@vger.kernel.org, hoeppner@linux.ibm.com,
        linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com,
        gor@linux.ibm.com, borntraeger@de.ibm.com
References: <20200417094835.60247-1-sth@linux.ibm.com>
 <20200417094835.60247-2-sth@linux.ibm.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <b748b144-86b8-f0de-e391-f24b50718a2a@kernel.dk>
Date:   Fri, 17 Apr 2020 08:05:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200417094835.60247-2-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/17/20 3:48 AM, Stefan Haberland wrote:
> CONFIG_IOSCHED_DEADLINE was removed with
> commit f382fb0bcef4 ("block: remove legacy IO schedulers")
> 
> and setting of the scheduler was removed with
> commit a5fd8ddce2af ("s390/dasd: remove setting of scheduler from driver").
> 
> So get rid of the select.

Applied, thanks.

-- 
Jens Axboe

