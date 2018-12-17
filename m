Return-Path: <SRS0=xbel=O2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7B8CC43387
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 18:28:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7511F21841
	for <linux-block@archiver.kernel.org>; Mon, 17 Dec 2018 18:28:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="UVuabSIw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728149AbeLQS2P (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 17 Dec 2018 13:28:15 -0500
Received: from mail-it1-f169.google.com ([209.85.166.169]:56260 "EHLO
        mail-it1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727838AbeLQS2P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 17 Dec 2018 13:28:15 -0500
Received: by mail-it1-f169.google.com with SMTP id m62so323770ith.5
        for <linux-block@vger.kernel.org>; Mon, 17 Dec 2018 10:28:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=u+IT8XwE8eGkqdi3FXUDg5crG9Dd5+mFhARHa1/V3CA=;
        b=UVuabSIwoq7CCds6wCCw9iT+S1apbesds+K1Z3nD5JcLyDLDR4VAGYHeBFGLvuvYZs
         JhlEmPauJ54vYxeQVajOsW3zn4y/Bm0uEdDnvgbeh2wGaC0IX7PiWk/Y9/MeBBIBAk3u
         HK70pDs4zlTyycZhY0l/nb+7PwSwucDyt4hPN5c5JU6RxQOrO/lvC5uHf9gJC+m+EV4V
         UDAt1YNXqJQW0Z3RgrxevJchYhMeiyyl5AFr6AvOgZvASYIPy8Wg43yuxxYHLxcnEXgy
         1L5GrH4ea+PubpMyq8e2a7kkK+V8mBpUbedJTx0JjpCLJ3pXtUrZcPhMjc2eXlMg39Yg
         dgcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=u+IT8XwE8eGkqdi3FXUDg5crG9Dd5+mFhARHa1/V3CA=;
        b=Xh4PS1VEsbuGRlEJc+eWwb37wDLjRcMuoQqPZIMOGSCzYEARqzyzRfGrfp1qkqYNQk
         K+0SNwP+aNJssCLNA9SRVqm7IJCRD3LcaTfYFOdVR8UmZci32hW8l/Zs4gqVESy9l6+/
         YA+3YCZlb4xjKgaJ0tkAEtrItdJV6OKBqgoYEw2T1qFuGFKWHa7hrQtTLjSOaliDU8hy
         WotX5bpfQYWf7+e0vyqjM+ueJUVB2xu/fIgNb1Th5ywhOCw4lYXVGhtOBK80Lo8a4oCL
         prP6oIuYV9C/kLSTl7EAlMIwZcoJEMG5F8UcBZEMQGnmrXu1SWm5ow23iuFJPrSsHZN5
         LY0A==
X-Gm-Message-State: AA+aEWZeAxHtJhltqwrzZYUNOVT/Dm/o39tm3RYyxRsE2GDl20xPKp45
        1ylo/tK95cPxJ8cOY6y6P53nOac5bnfnYg==
X-Google-Smtp-Source: AFSGD/WsNbmuRWbP+L5c+INZ9+v9u7Z552+zwFTRAeFvP3NcGraF7W5jlC/t/uKhv/JoU4dG9uTV1Q==
X-Received: by 2002:a02:8a1c:: with SMTP id j28mr13148859jak.49.1545071294088;
        Mon, 17 Dec 2018 10:28:14 -0800 (PST)
Received: from [192.168.1.56] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id r63sm203978ita.2.2018.12.17.10.28.12
        for <linux-block@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 17 Dec 2018 10:28:12 -0800 (PST)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: Upcoming merge window
Message-ID: <6fe5169f-8032-ac2a-ecb7-f845c56b1d73@kernel.dk>
Date:   Mon, 17 Dec 2018 11:28:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

As I'm sure you're all aware, the merge window is coming up. This time
it happens to coincide with that is a holiday for most. My plan is to
send in an EARLY pull request to Linus, Thursday at the latest. If you're
sitting on anything that should go in with the initial merge, then I need
to have it ASAP.

I'll do a later pull about a week in with things that were missed, but
I'm really hoping to make that fixes only. Any driver updates etc should
go in now.

Thanks,
-- 
Jens Axboe

