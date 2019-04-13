Return-Path: <SRS0=i+2c=SP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEE0C10F11
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 15:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49A49206B7
	for <linux-block@archiver.kernel.org>; Sat, 13 Apr 2019 15:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AgYmBfI3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbfDMPeK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 13 Apr 2019 11:34:10 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:45076 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbfDMPeK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 13 Apr 2019 11:34:10 -0400
Received: by mail-pg1-f179.google.com with SMTP id y3so6558221pgk.12
        for <linux-block@vger.kernel.org>; Sat, 13 Apr 2019 08:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6+D6RZR1bzew0VlEyESUVbz4kDrff7odWgr0ytyO7dE=;
        b=AgYmBfI3zCBTdbQSu96oXXMif4ObzJQcTYmnutPHaLQ6fGA3aKsEvl4tcM1Wvj9lhl
         t5FHDPIe+QMVUokGEDegGzUBAAZIKZgm/tBr253A04vP8HjXmJQG3+6y2gQtAZXbBZqQ
         u4yzn7XKxBzD63uxmVkIX/xQhcd69A9vSE0cqz4L9dtXJd9nDEeevcDe7QscSFuAR0N9
         TQl96Ve3BfBrZ2jRXfu9mS+DGbQFuOCJZWITxVXhEFixYvw6Na3M/S4nuprbb678MJ8x
         2oC8LL2r1cnNDSpRAvSU6HRORGuKsg9vtb1gcV2aw1kRPbDC4CpCfIbYnt7KP+LvCJ0A
         DG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6+D6RZR1bzew0VlEyESUVbz4kDrff7odWgr0ytyO7dE=;
        b=phswD9h7TgHMcm5arUa/xWGThF7xA3RnvrBbPZS+0a5+2AAG2rMjiRv/AE9Ifg2DrQ
         73CL+8e6WQqjn7uC3Kkxlzwxhgq4zy0NFzBy8RN33Ln7m5KFtiwGr1ijhu6oAShx/oWU
         MeTuRpUlUlOkfy8QgjgLaM3LkYLXPyVtWkOXWlLK83b1GnTkF/w3ED78CuvCE0VCFN1a
         dowNAGRZeTxkC7gL9orGEelrx6L+HIA3CBLB1P16n4XUmYVf1wrn8CkJrRzhWoGaz4Ek
         brQxp0mrlQxuvk9Ln/pRpbOhhtDz/EcKKypioOzRF2Ch6/jDvL73laHPUZpmUaNV/aoB
         oR1w==
X-Gm-Message-State: APjAAAVlcoNJqwdEeoQn2pg6J0cm1xzx62W2EWYFOp12p2cplSUG9dgS
        e0zcF/eBWDlfmh4vfcOJwsoYJQ==
X-Google-Smtp-Source: APXvYqxihRV584HX9+mhlqE6CsaNFSRB4U/8gG1VrbNHhfdwCxucK5JGzMmqE2J3FNtv+spyhYX8Gg==
X-Received: by 2002:a63:f707:: with SMTP id x7mr60757298pgh.343.1555169649590;
        Sat, 13 Apr 2019 08:34:09 -0700 (PDT)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id b2sm55710261pfo.150.2019.04.13.08.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 13 Apr 2019 08:34:08 -0700 (PDT)
Subject: Re: bfq: update internal depth state when queue depth changes
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     Kai Krakow <hurikhan77@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        hurikhan77+bko@gmail.com
References: <013ca038-559d-0a56-4d49-366c7ec79ac3@kernel.dk>
 <CAMthOuPohGUM8gqxE8xoLdSnVaU2iEgOT60fqddWbsoDZSy0CA@mail.gmail.com>
 <280d9cac-6373-8e90-dd52-11183db2e253@kernel.dk>
 <C072E94A-C227-428D-A7CD-E804D6FF2CE6@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
Message-ID: <0aac930a-0006-a841-9a35-5d0038553012@kernel.dk>
Date:   Sat, 13 Apr 2019 09:34:06 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <C072E94A-C227-428D-A7CD-E804D6FF2CE6@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 4/13/19 9:18 AM, Paolo Valente wrote:
> Hi Jens,
> I'm not finding this fix in either current rc or for-5.2.  Am I missing
> something?

Looks like that slipped through the cracks, I have applied it for 5.1
just now.

-- 
Jens Axboe

