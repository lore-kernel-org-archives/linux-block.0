Return-Path: <SRS0=fNpn=NX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68CBC43441
	for <linux-block@archiver.kernel.org>; Mon, 12 Nov 2018 17:10:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9175A2245E
	for <linux-block@archiver.kernel.org>; Mon, 12 Nov 2018 17:10:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="kmXb/r+T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9175A2245E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729373AbeKMDE3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Nov 2018 22:04:29 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:35425 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbeKMDE3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Nov 2018 22:04:29 -0500
Received: by mail-pf1-f194.google.com with SMTP id v9-v6so4620953pff.2
        for <linux-block@vger.kernel.org>; Mon, 12 Nov 2018 09:10:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=ej2zWVNDkKDNwVA+EVbiOGWXtvZFOLaPlACrw1hHV7k=;
        b=kmXb/r+TPkHme/w723MEjEX1OmHpW0Rzgx7MIqmYbImnpm7bgEJJFyKtMTgh+aQVte
         agicwsN632siixG/62KiWdGhoU46apMOF1brZjdXFJo2mgEK9HrjoOb55+V8JJPKQmj0
         ti08t693wG1g4M5YwSIPIqIQXBzq19GG4j+OuLtRXOqn8/2oFn6SXOcXh7HdYqVFD6bE
         AdtKnoNSsJQvNP62bXDvoSRh+lDcqpKt+ZzoR9M/j+dq5gnYH3mDLtkgblIsxSZnPV2u
         V6hUZaKHXLAgEDKbb2CvJvv2WW+Ae9xaNC5/NUMBNMzk9qsdXXHHfZZeVRzZ5WfOyAeP
         9QrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ej2zWVNDkKDNwVA+EVbiOGWXtvZFOLaPlACrw1hHV7k=;
        b=WSlKrinepnQs1dbvHz3movmoCbaCy1D9Ym+qEDE+Stcir5ba6X4MW/4mngvWcqxpvY
         CgjiX/eEDGtGACOjn2vg0J/s4QdN/tHVOXiU6ROuz1Il8ZSN/ae5bfYIqxroDEOrOHdT
         jjDQfKwFc6lHaSUFJwhT0w0X1+e+nBphh6SE8h26s3hAC6SGaINwzT7kBywU99U1bjlR
         YzSreehzyboGjUhqCMl6qEYrJzkdHGGfuLIGSAdqpoCjwPdfp+RcdeklhPxwLh2+enYg
         ohRuq93r+fhP1jujtnmXkbuqkoC1A0OHHUef5t1MzKRPyyxs5wWDCJiuVqtvUa+spwyy
         OYEw==
X-Gm-Message-State: AGRZ1gIqZDZPWXvWF5OazAzdpq9lkLlA0EDE1J0jwmr1KTRnBUB3UHID
        r58AfPa0fO8WyOUlLuPJXCTobg==
X-Google-Smtp-Source: AJdET5fNMpBXSVwTARCXCIhhgisnHkPzwszZOFeYF6eVG46zcK2imqa2HIyMDB12ukhRBLBV8biyIg==
X-Received: by 2002:a62:3a82:: with SMTP id v2mr1661841pfj.174.1542042620858;
        Mon, 12 Nov 2018 09:10:20 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u82-v6sm204925pfj.131.2018.11.12.09.10.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Nov 2018 09:10:19 -0800 (PST)
Subject: Re: [PATCH V5 1/6] blk-mq: make __blk_mq_issue_directly be able to
 accept NULL cookie pointer
To:     Jianchao Wang <jianchao.w.wang@oracle.com>
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1542014609-1769-1-git-send-email-jianchao.w.wang@oracle.com>
 <1542014609-1769-2-git-send-email-jianchao.w.wang@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <01bd2f70-cc78-9bfd-aa30-b73c44eaa9bb@kernel.dk>
Date:   Mon, 12 Nov 2018 10:10:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <1542014609-1769-2-git-send-email-jianchao.w.wang@oracle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 11/12/18 2:23 AM, Jianchao Wang wrote:
> Make __blk_mq_issue_directly be able to accept a NULL cookie pointer
> and remove the dummy unused_cookie in blk_mq_request_issue_directly.

What's the reasoning behind this? Seems faster to store the cookie
always, instead of introducing a branch to the hot path.

-- 
Jens Axboe

