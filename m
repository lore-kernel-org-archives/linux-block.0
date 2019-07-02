Return-Path: <SRS0=exTe=U7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F051C06513
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 16:18:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B29A20989
	for <linux-block@archiver.kernel.org>; Tue,  2 Jul 2019 16:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="hlWiROmq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727029AbfGBQSI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 2 Jul 2019 12:18:08 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:41478 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbfGBQSI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 2 Jul 2019 12:18:08 -0400
Received: by mail-pf1-f196.google.com with SMTP id m30so8475792pff.8
        for <linux-block@vger.kernel.org>; Tue, 02 Jul 2019 09:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DAx7CR5b5Uo7y8veOHTVUwOdauPdR3rS+YxQZ2rIlNU=;
        b=hlWiROmqqTS/AfOzlQDLEbqIumoNJNVoWwQwVwhpzURZJ2m3J0SRARq7ilOfIPqHuo
         AvVYJZDlRvQG2Jlrv67+IkOlZqj5hsgB1IOHExKhIwRJHAAP+V9Nz/5UKwC/gwlLzmTK
         Am04uGxssRum7Zy8DX/g2ZZXWZG4t9/sVitMp3QUzmw4AjmBs62BEnxqYN7X7b7O6psO
         3xlw8X7PNH00KZCCKbetp2EqkEL40mhNyzRxrLCSZoCDVoik5jAnp0ncJpzjip4rrmm0
         mFOWnfIQr5ywwJjzxEUxquDnvkoSyI1gVlJVbjpEA9nea3CHpeMOfp13GCzp/1LlWqCd
         G6zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DAx7CR5b5Uo7y8veOHTVUwOdauPdR3rS+YxQZ2rIlNU=;
        b=shWlj6XKPIaS0mKEZUvrNHnRPjunBlApq1EobatJlgII5eHByRY+3R2PbPl9HxzjPG
         pdDyhxx2WDog8KIlZLMx88cQJ7WyXgSbJr8139fbDKb/J/4zX3DVGeKsuZJ01gxFPaMO
         Z89eamCvW91s95l9C5iT7Ik9q//JDS+8XLPudTY7NAYjZ1cgm3OMEXsRSC1rJISbLW5N
         KgXjLk1hyPaTI5sSpdJ1cg9Taox6w7+npdQkDsmDVsuuUWBgs/Ak9T925C+0m0nVonXI
         V0095eVnqc62TJbg7CRbnikztvTi4sNnZ2TN0I8EfTSQQWERBxv2DkX0fS2ke86EWQCt
         eMrw==
X-Gm-Message-State: APjAAAXXAEB7auwsMmcqKFkqFkZseseC1mlbmIf12SCRNTFG89qfM84K
        8VT4pb6GXW6hzq1kaf6tZIX4PfjPeT4f0A==
X-Google-Smtp-Source: APXvYqzhuFnjd/3xDcEjVQOpFlDA26WE0mNUpxczeDcrzauxw6iDyfnnSFr22WzgJDV47SbGf9JW5Q==
X-Received: by 2002:a62:1c93:: with SMTP id c141mr88752pfc.9.1562084286946;
        Tue, 02 Jul 2019 09:18:06 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id b6sm1453750pgq.26.2019.07.02.09.18.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 02 Jul 2019 09:18:06 -0700 (PDT)
Subject: Re: [PATCH liburing 0/2] Memory synchronization improvements
To:     Bart Van Assche <bvanassche@acm.org>
Cc:     linux-block@vger.kernel.org
References: <20190701214232.29338-1-bvanassche@acm.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <e99e6a26-08ac-4318-c012-5f5b2bb6cad6@kernel.dk>
Date:   Tue, 2 Jul 2019 10:18:04 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190701214232.29338-1-bvanassche@acm.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 7/1/19 3:42 PM, Bart Van Assche wrote:
> Hi Jens,
> 
> The two patches in this series reduce the number of memory barrier calls from
> liburing and also fix a few memory synchronization bugs. Please consider these
> patches for the official liburing git repository.

Applied, thanks.

-- 
Jens Axboe

