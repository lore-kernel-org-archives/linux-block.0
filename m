Return-Path: <SRS0=D4S7=UT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89498C43613
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 09:26:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 50BFE2083B
	for <linux-block@archiver.kernel.org>; Thu, 20 Jun 2019 09:26:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="vYO8y7Jk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726071AbfFTJ0o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Jun 2019 05:26:44 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:39889 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725937AbfFTJ0o (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Jun 2019 05:26:44 -0400
Received: by mail-yb1-f196.google.com with SMTP id i6so974910ybq.6
        for <linux-block@vger.kernel.org>; Thu, 20 Jun 2019 02:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=yhqOWcsVMRLUugSeb1eby5Cv08pN53Ic4ZUoxcG3TJo=;
        b=vYO8y7JkLy+Kw57JCh+SGP9xT4ECOc2Zr9Btu65hng9dKnuiBuZk6CsiLkCq4RBBiE
         Rt814xsd2FG38spTJAwavWlrASeDrh04YJy6BJV2PJ8gnMbEFt3i07KWpbSr4StC4UMx
         XczfK91OAASx0SUJsrdUKv4SdNXbPUbAscwoQb0bJuux7Dh4aROJ6g47hv1MQd1ZNkgG
         1JOi23/ECEeqQaKoBA+/eNJ3TqKAigbaQYavLEKdbP8Nn9w5dY5meIxOtFRztn7dx3xZ
         d2bTtAubK2N1SigHRkYOEgU1px3bBnd3xTKzPWbMlxtO2pk2g0d0XLAWT5IqLy74MM63
         9PeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=yhqOWcsVMRLUugSeb1eby5Cv08pN53Ic4ZUoxcG3TJo=;
        b=IcX4HeXOXR1VaRjFLPwhRC0hn+1iOs7g+j2K4EZ40W6tbF+JpeE03AC05dW/6iSOsH
         ateL5cDlt/T6QvwZubdWn9/xaiP7Gdo61N7LORr1wTqUdDnUFHL2v6dDIae/0UeDdNdG
         HQqkc5xu7AQ4H9MKhz9WsqEIZkCpvXQdcwyvB9nn6JbLtPJ08dOdFZXpRvU4CNz7Viul
         pZ0tSSUlMRGQp7tZpLiNpdHqhkhd6HTUnQNcsPaX2dZ3fI9FDKI5dCeixeXZ4PVGU++/
         Aa+VWIK6KqI1uEVhGhSQDCOtW+C5UcSR01eokgNWABT8HvMH+f/gw258ViQi/qjP3hUZ
         eltA==
X-Gm-Message-State: APjAAAXVLHpLfHf0QL1nYLJt79EXpk1ozlauQ+NrxKnHwwGJ3EocuNvC
        Zm+hrLIrXQAwYGNuvSMUcJTBMQ==
X-Google-Smtp-Source: APXvYqySUz1cIJX6NDR8ngA1GjoraRplX/O24N5dzHr1ye9UYfXOj4X5kPzZsGimkTHVjqrgsBpHlQ==
X-Received: by 2002:a25:cc0a:: with SMTP id l10mr7239938ybf.433.1561022803695;
        Thu, 20 Jun 2019 02:26:43 -0700 (PDT)
Received: from ?IPv6:2600:380:5278:90d8:9c74:6b59:c9f5:5bd0? ([2600:380:5278:90d8:9c74:6b59:c9f5:5bd0])
        by smtp.gmail.com with ESMTPSA id l143sm5657391ywl.107.2019.06.20.02.26.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Jun 2019 02:26:42 -0700 (PDT)
Subject: Re: [PATCH 1/1] blk-core: Remove blk_end_request*() declarations
To:     "Pavel Begunkov (Silence)" <asml.silence@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <8c174fbe05ef879f2443b01e3ffb340a7f524d40.1558626111.git.asml.silence@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <23ecea9b-7833-5b77-11ae-7e989cc89385@kernel.dk>
Date:   Thu, 20 Jun 2019 03:26:39 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <8c174fbe05ef879f2443b01e3ffb340a7f524d40.1558626111.git.asml.silence@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/23/19 9:43 AM, Pavel Begunkov (Silence) wrote:
> From: Pavel Begunkov <asml.silence@gmail.com>
> 
> Commit a1ce35fa49852db60fc6e268 ("block: remove dead elevator code")
> deleted blk_end_request() and friends, but some declaration are still
> left. Purge them.

Applied, thanks.

-- 
Jens Axboe

