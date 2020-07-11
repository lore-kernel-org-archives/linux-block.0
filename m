Return-Path: <SRS0=SfXy=AW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17DD2C433E1
	for <linux-block@archiver.kernel.org>; Sat, 11 Jul 2020 09:34:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEF1220725
	for <linux-block@archiver.kernel.org>; Sat, 11 Jul 2020 09:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="B3lTnE6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728138AbgGKJe4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 11 Jul 2020 05:34:56 -0400
Received: from mout.web.de ([217.72.192.78]:55283 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728102AbgGKJez (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Sat, 11 Jul 2020 05:34:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1594460078;
        bh=lkv+WEC3NOxHLpGKrgZaJC4IUNQ3MwNs+ibum94Qa+s=;
        h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
        b=B3lTnE6oDxgsYgbOrUMr13FXdJJFO3H4xL4dvyWPF1VLY/3BVupG5bEhFbTN40WqT
         7uOExGCzHAtpzdKjaMa1Dw3a/7/UJLhw8XeCjZTImh/q5KXe+mq1weuLMj5K8GJ+NE
         Y5LLYzUd56TN2+R/X0RdP4XnVOGqzGvFK+0kfLl0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.101.136]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lb1wz-1kZcJj2Au1-00kjOn; Sat, 11
 Jul 2020 11:34:38 +0200
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>,
        Josh Morris <josh.h.morris@us.ibm.com>,
        Philip Kelleher <pjk1939@linux.ibm.com>
Subject: Re: [PATCH] rsxx: switch from 'pci_free_consistent()' to
 'dma_free_coherent()'
From:   Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To:     Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
        linux-block@vger.kernel.org
Message-ID: <65ed731b-8582-cc1c-5591-13feef1d134d@web.de>
Date:   Sat, 11 Jul 2020 11:34:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
X-Provags-ID: V03:K1:HawYMCXjTpTUSlsevLiCn03QLNDvDwDWEpuFtJ05g0wUNfF4Nth
 EDPajPWdegBzt41eIgndu1DWGZYqsi+hf36T+Edg570KQen+ZqXPcPca+8qHK2sOiPN/crZ
 rAw/50woJRCzZibBVQITR3Em3+Y0b20P6Pj4YiO9MNps9iNhkTLUo2HtmBjmKbgUzCw6p0y
 VMlXlczNL3sqE3a4vtrTA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9e+xpc3o4/s=:2n+SMUiWMfpDwJc2smuzM0
 NHoQ3zw9JeBCktqtowR9UXmmgRJavmAC9Pib7eb7wTzu7OfEVXB1FLklOUlzWkAKxjusi4YMX
 odZrwKSOblMvsE2/A2KG0yvivedHz2FB/2rq0aNGn22DZ6Rv8wWw0buxUwOFGorSPPY+UAl1L
 KMiLnnMwYML+IqlCn+TZEjDdUhnN2Co9VqmEuHBWjjLx8RFMZvMCpBgYj73cdrC/kmwFbiFTp
 D0A7rRRUBpMPGRBrHXNkEB69UEOz5bOhrx9wbJwQO29VZ1NOdwISSdxeK6gpp9yckLoa4c8i6
 0yJ6mcjO8u7R5BJWAqw73MERY1hPPgJv7Wd6EjdEmAkivsME/8g9f3EnAu2ssflg7zDg0Q0di
 tZ2J9m4Aawqq5goLuooCqDtHPvB1qYMvfPOzIV8u3gmolJnLWn/vg6+EkpfMAY+XxdvRu359P
 gbAU4Qi6CiYO0gbg2sWujnYIQ0sYQ+AKzKGRaLH+XolU53n5GE7Zg5zAW6LIOF5JnfQhW3wa2
 qLqEPY4ItYPsX+BSgEAQe2/QqQ+WhBzubGtyVPdw/jeew8H8SS7Ukw+SrMf5DFbwlgwyeHkdL
 j5yMUIhwgYiHU+u1stiCd8V1VE5yg40JmyOWeEIHI8HcsylrNro5KxCJtO7Yu98mo5Ao4UM+G
 HWkVD6oslu+48l7/0FGZH4N1qx3LDfQHtXlZUotpB/weWK4WgZRx5qMTM95Ub10WuiM6sZi7j
 uGNZK2FHC6+vUkftYV3gJ1tQmZ/ScV7Ma6c44ubIFb+Mubh2kK9pN4WLOERF8BtFPnQM7QEki
 eewvzB8ogeeym/BPykWE3boTwCC0EsZ0Dl/wBnyBru/5y0mkDV+/hZMN8b2Cg6j1g+JqqTiIL
 fViHdAPNYOYKCUMo0gnX3FGbMXKl+VzoPGt3tizo8ya6hJCR0J1zdt5AqN0QCODKHRi7wwAv4
 1NEDUy9aXb+iKxGlmGteOUpK5WPk5BF7xqgSatRAeF6N6hCB8PLjdOKnXaO1J1N6+3U+R/qmW
 1qKdGI3gqQqTBcvH9A3MnMK9sf/9Mypb13VuTgtfqRO9fNlqkRSVp0Tpicop/M0EjFAQdhW8x
 v6e+kbHKpfuZmgFBosQGL6+CZ+itOmE6rgiHptiUvWB2b+0+jrgzLqL3+31auR0+2KQ9EcJHE
 wjoeA5eOsyZJkhKW53kobaiyHgqGdS1q5NMdly1JG7xn2xFht6q+xLtj7df9KfyxbqrQn7znN
 nOPYImOf66fVm54Arez6ZRZ/Lhtdf9hvDR8xXKA==
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

> The wrappers in include/linux/pci-dma-compat.h should go away.
>
> The patch has been generated with the coccinelle script bellow.

* I suggest to avoid a typo in a word at the sentence end.

* The script for the semantic patch language could be a bit nicer
  by the application of a disjunction instead of separate SmPL rules.
  Would you become interested in any further adjustments?

Regards,
Markus
