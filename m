Return-Path: <SRS0=Rcoh=SY=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4893AC10F11
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 14:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 11AB1206A3
	for <linux-block@archiver.kernel.org>; Mon, 22 Apr 2019 14:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="zfzbdKVO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727568AbfDVOW1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Apr 2019 10:22:27 -0400
Received: from mail-it1-f194.google.com ([209.85.166.194]:36051 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbfDVOW1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Apr 2019 10:22:27 -0400
Received: by mail-it1-f194.google.com with SMTP id y10so18433951itc.1
        for <linux-block@vger.kernel.org>; Mon, 22 Apr 2019 07:22:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xg76K0fZdEsoPtBtQ5C2TWI0YD1xFpLJldINbqy9x7c=;
        b=zfzbdKVO3AvDGPbiINEfnf0FRQGFtx7or/Y0zguLz4lLekcTQjc+LrHWha8RaL/GF1
         Z0GKmZONc4NfwYcFKmv1cZQtqZWEIf1py9dFxx1oJ3aaGP9ud4q77ls759b0BzQuzEar
         WsMDU1TYnfR3ecuuDUI0jpgDE9nRHAS5PksQp0UXYjV5V28JHqsRaU5/gWkCNe7rHR10
         4/lT/ugQEEZszQSwocuyoXmoERR9dX74VyywQeK2kfmBI8zRSagIcuqdAZnWovwzGa+V
         7tCXFHq1F0HMYX1bbun34WeORzex4GUeymj670Ke25KMs+h6f/g6AG2RLiIyfK/VbQdg
         JJuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xg76K0fZdEsoPtBtQ5C2TWI0YD1xFpLJldINbqy9x7c=;
        b=kfdeWtvST0sYq/JdkAB8FfFDEOC6vdvblYJDoopw5mjd+/DkGwHYY3/DrDSlgCJ842
         jkzJXtt5KKaIbdVoDysyiuPifIc6V6fzo2CjuRHOitsNL2OrQLSCm/vNps2RYAQQHKCW
         L5dWsFB1lT/BMkjzoDkz8OH23n7AEdBjXQlwf1hsLgj8F9WVoQwzVTHilillsLWajuvI
         HGHbBXD6epAfcRe8FJBqbIZtsRiOZeMj4Ptk42kjIGORBwmHJnV26R7fxxjn2vZpcxMC
         4TG1iG4qYGDXXwWUDO88bmiCeXzwlHDToxSIyJ+MvUh9OSWYIQr5o/ZCBcJdYr/RJ9EP
         A2bA==
X-Gm-Message-State: APjAAAUN9NRtFfn41AajFbpWtccuzvPiNf2ImCLdlWO7hXFMMd4dawet
        QGr6zBdVyY/uIN+8ZPOzWLEcUUlidUdB9A==
X-Google-Smtp-Source: APXvYqyykwF+gaT8LkKeH+69eAzaZ83E45jKYfLCT1KzYFcwT/qGamivOB0xs7YfLNcdnGgSbxf95g==
X-Received: by 2002:a02:ac9a:: with SMTP id x26mr13660033jan.129.1555942946212;
        Mon, 22 Apr 2019 07:22:26 -0700 (PDT)
Received: from [192.168.1.158] ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j23sm4364838iog.59.2019.04.22.07.22.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 22 Apr 2019 07:22:24 -0700 (PDT)
Subject: Re: [PATCH] block: avoid scatterlist offsets > PAGE_SIZE
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux@roeck-us.net, linux-block@vger.kernel.org
References: <20190419065624.25583-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <13421aa4-8a95-464c-39c5-f0f00b17891f@kernel.dk>
Date:   Mon, 22 Apr 2019 08:22:24 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190419065624.25583-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/19/19 12:56 AM, Christoph Hellwig wrote:
> While we generally allow scatterlists to have offsets larger than page
> size for an entry, and other subsystems like the crypto code make use of
> that, the block layer isn't quite ready for that.  Flip the switch back
> to avoid them for now, and revisit that decision early in a merge window
> once the known offenders are fixed.

Applied, thanks.

-- 
Jens Axboe

