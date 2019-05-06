Return-Path: <SRS0=Wczi=TG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83E50C04A6B
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 16:38:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53FEC2087F
	for <linux-block@archiver.kernel.org>; Mon,  6 May 2019 16:38:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s6J8bnqd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726505AbfEFQi0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 May 2019 12:38:26 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42757 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726063AbfEFQi0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 May 2019 12:38:26 -0400
Received: by mail-pg1-f195.google.com with SMTP id p6so6709047pgh.9
        for <linux-block@vger.kernel.org>; Mon, 06 May 2019 09:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=W3tyqiwSrG5uqKuXmhCbfkfXOGDKRU1cvNSJPUYJVdE=;
        b=s6J8bnqd3KHv8WkEguYkHy0P4cACy9yLewGgNg80b5znbZztQxYrEOdKg4D3rkz5gV
         wenAXNSyTGF8hE7vwprQoTPXW+VsSyL4wPOH1nxFJS2/SZbsi+z4V6OkSqRGvkOLC6sh
         L4yPgY3Tt1nOMH7oSH+MaugxPmB/s+h0rjaGERR3CW/qTY7H9scJoW9kwscVv9bBfT8e
         1hWQ8UanYjyBEFa+CXmshzl/gQUh2yo1nWdLjKJDAvPYDCBl0urcPuzPU4p25KNuRT53
         UzqYIChfJIMDV1MHwJUfrv69GKcrPzSI+IqNbe1yNXxBKvnhfe4OtLGLMMxekvosCmV8
         07vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=W3tyqiwSrG5uqKuXmhCbfkfXOGDKRU1cvNSJPUYJVdE=;
        b=fn9hLPJ5dclmjz++D0G57J2oDLFX3XD8iwkPwnZMNEPh6W1srT8jvyw/8uSktFauho
         MwrMdQnI7NSFMwYyfIDkaAV0SrEFLV7ZPOJ4FnndeZinUzyEaISo6akgChRNyJ8W2QgR
         KI1SmWaVGMNxJmdjQY6Odl9VqlUsb+9rzWiwQ93SYp6q9uDJvxQMYiL+hppwUo5QAd5O
         9gi1PPUa5TojxNCJde09H2oZ/NVWjn/W4G045982458Xrbg9vHXNjIDjD0FrgpbGfODL
         5TutQfpE1r+/jIb/3PKRcSa61YCI9I1tenwHBuAlJ0tlmcWNYHgPCQFYFuUGtH+oIbDM
         6dBg==
X-Gm-Message-State: APjAAAUFUoGjeJHB5+XqOfVWqtHbBaYhc6DOyip+vYZlRHOrGbD+flws
        alUE4M7/Ch8NGJUQg5N3RbM=
X-Google-Smtp-Source: APXvYqwCqAY9JWv8s2W6kEqNZ2DSsWZpTo3BVNMpoe60rP4Aog8S/eUlHFsI95ZAzin3z/qpXyRQgw==
X-Received: by 2002:aa7:8e50:: with SMTP id d16mr33692555pfr.227.1557160705787;
        Mon, 06 May 2019 09:38:25 -0700 (PDT)
Received: from [192.168.0.6] ([123.213.206.190])
        by smtp.gmail.com with ESMTPSA id y8sm14438016pgk.20.2019.05.06.09.38.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 09:38:24 -0700 (PDT)
Subject: Re: [PATCH 1/3] nvme: 002: fix nvmet pass data with loop
To:     Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
        Omar Sandoval <osandov@osandov.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20190505150611.15776-1-minwoo.im.dev@gmail.com>
 <20190505150611.15776-2-minwoo.im.dev@gmail.com>
 <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
From:   Minwoo Im <minwoo.im.dev@gmail.com>
Message-ID: <a66b775f-9a5f-fefc-ae29-c86678e66463@gmail.com>
Date:   Tue, 7 May 2019 01:38:22 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <SN6PR04MB45274C423AA7C3CC3DBB5ED586300@SN6PR04MB4527.namprd04.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 5/7/19 1:25 AM, Chaitanya Kulkarni wrote:
> We need to get rid of the string comparison here.
Chaitanya,

Do you mean that test case bash script should check the result of output 
and return some error value instead of zero instead of *.out comparison ?

Thanks,
