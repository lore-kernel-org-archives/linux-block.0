Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E10C7EC875B
	for <linux-block@archiver.kernel.org>; Thu,  7 Sep 2023 21:27:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbjIGV1Z (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Sep 2023 17:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjIGV1Z (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Sep 2023 17:27:25 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7E21BD2
        for <linux-block@vger.kernel.org>; Thu,  7 Sep 2023 14:27:20 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-1b89b0c73d7so2497575ad.1
        for <linux-block@vger.kernel.org>; Thu, 07 Sep 2023 14:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1694122040; x=1694726840; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kfkT0bUg5dFL0RmzhNpX1DLqx8M5IR6kOY1LkXY1afw=;
        b=g+XOWtoIE/ibQn0FJrDND5KU+PZ+xvyvKBTF8F6zDEh0ZO/huL491G2Gdqw6qQ0XUs
         yqdV6uDNI297dy5k7eO1RMj6NIhQnTy7AXrwWNRwh/WEy1xPRKnJ5d7dx0iuRvtNHIx8
         obCLpvhPnbj08xzy2CTkeo6ToOW/vfFLPeECkg5ib0FOm4akEF5eCSml6EkWCn5bfF9U
         LwG8hHrNjWDeFVY7+hGWCUp4XWbD+LhPNeb8MJUd+fz2S9L/M14k3ZdeEU4ILqiUuwaR
         gvrBqqOrWfvLkdV1fvcih25QRWvRdXoIGC7/sNVVNbmcUZh3zN6yVX59UB2dY2uF4j7I
         GvPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694122040; x=1694726840;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kfkT0bUg5dFL0RmzhNpX1DLqx8M5IR6kOY1LkXY1afw=;
        b=a1CNxJSvzvo5UHEgEjIx70ezdixxJyL1xfEWJlz7WJ6/C0AXejYL4na0teTfUMl45M
         XpbZjx8E4ZT+ExCGAkLzrX5pnsT2J73652YZrEO2Qs5FKZIcmGtuUBgMHECbXG43W68J
         fKEAomOx4poqkWAO7ctyIY3Q9JsS534sYycsaK3ZjuCLUU32IhcbvxyTf9Q4QG0nmB9P
         HfRbBrZ8zbbIE9O0fJqCZNI+K8PrDH9hj6U3uGiExenzmQrt6ujmH86FKiiBFRtTiV96
         m9rp3LB4bX0C5gGY+W4CZTaKepXv2X1INVUU5TeK2pMsNCKld4TqTxS12X0ax0talW03
         9r2A==
X-Gm-Message-State: AOJu0YxbHb6gNn8P05jf4up481yVivzHz7obr6QgwGpBIV97DOOUnjE6
        /X9gVJnurujoh4uhH1QnCuNKgVKnhpUUHWNOgyM=
X-Google-Smtp-Source: AGHT+IHR7HofpF9T2MmNlZB6esIBkpsiTRR+T3BVuKS/LfV0XwDwnA7XryRIc9xRtzRHN5bkByOCfw==
X-Received: by 2002:a17:902:ced1:b0:1b8:a469:53d8 with SMTP id d17-20020a170902ced100b001b8a46953d8mr889000plg.0.1694122040232;
        Thu, 07 Sep 2023 14:27:20 -0700 (PDT)
Received: from ?IPV6:2600:380:7457:42ac:56e5:c632:552:f5e0? ([2600:380:7457:42ac:56e5:c632:552:f5e0])
        by smtp.gmail.com with ESMTPSA id jh2-20020a170903328200b001bc35b14c99sm188752plb.212.2023.09.07.14.27.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Sep 2023 14:27:19 -0700 (PDT)
Message-ID: <7df3e30a-aa31-495c-9d59-cb6080364f61@kernel.dk>
Date:   Thu, 7 Sep 2023 15:27:15 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: WARNING in __floppy_read_block_0
Content-Language: en-US
To:     Sanan Hasanov <Sanan.Hasanov@ucf.edu>,
        "efremov@linux.com" <efremov@linux.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "syzkaller@googlegroups.com" <syzkaller@googlegroups.com>,
        "contact@pgazz.com" <contact@pgazz.com>
References: <BL0PR11MB310616FC87790EFFEDCC7CD0E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <BL0PR11MB310616FC87790EFFEDCC7CD0E1EEA@BL0PR11MB3106.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 9/7/23 3:21 PM, Sanan Hasanov wrote:
> Good day, dear maintainers,
> 
> We found a bug using a modified kernel configuration file used by syzbot.

[snip]

To the best of my knowledge, nobody cares about floppy enough to tend to
any of the syzbot reports. I would strongly suggest that any testing of
floppy by syzbot gets disabled until such time that a) the driver is
either re-written to not be a piece of XXX, or b) someone motivated
starts tackling these reports.

As it stands, it's just noise in the block syzbot reports.

-- 
Jens Axboe

