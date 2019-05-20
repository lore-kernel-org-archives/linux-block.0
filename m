Return-Path: <SRS0=zuir=TU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22B86C04AAC
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 13:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E759120856
	for <linux-block@archiver.kernel.org>; Mon, 20 May 2019 13:06:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=web.de header.i=@web.de header.b="EZXkc4bY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730381AbfETNGC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 May 2019 09:06:02 -0400
Received: from mout.web.de ([217.72.192.78]:44645 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730323AbfETNGC (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 May 2019 09:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1558357557;
        bh=rknzXpVaKA2Z+lrTZafpzIVeQ28bvD9kBYiBb6H96ic=;
        h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
        b=EZXkc4bYTZ/TbhmvGirI8SLZSQ9hzqHeEOfxJNMFOxfUz1pvfz1lL9nyDdj7so25P
         sWFoygbBHBzNQ+dTSzhKbHvRbtoJ/QLw6PmD82qWWniaLuCmYiYz9OwEoXxa4wRghI
         j5OArNRwxE+TAs3iniryKArXAhWL2fi5PbDOLaxE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [10.1.1.111] ([109.192.195.184]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LfzxX-1gqtBe3CZf-00padR; Mon, 20
 May 2019 15:05:57 +0200
Subject: Re: Adding QCOW2 reading/writing support
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Hannes Reinecke <hare@suse.de>, linux-block@vger.kernel.org,
        linux-block-owner@vger.kernel.org
References: <60bbe5e0-317d-8ead-0eb8-d1dc79927bc8@web.de>
 <c6b31507-bb02-c886-aea6-4165606f215d@suse.de>
 <762bceb9-c66c-0a45-7d6b-e5ed0df56cbf@web.de>
 <7a74dd35a390df25f2874aa7b4f8547e@suse.de>
From:   Manuel Bentele <manuel-bentele@web.de>
Message-ID: <cee07f0a-59c8-3ee9-bcaa-8b38f1de2756@web.de>
Date:   Mon, 20 May 2019 15:05:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <7a74dd35a390df25f2874aa7b4f8547e@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
X-Provags-ID: V03:K1:yyv654e6Wyg+/XSTC+Ql5KDcGLh6R14Mki7g1cv9ANZZEzzNLRx
 YyuVRTxRdOR4JFPPF5/rcfhIYdbX+pBMM/qbKUskht1jDHw5M5EPYclFnz902oEBN9qqmAc
 h65ij1f3WscPZKDU9b/bnXs0+4Zyw9UPs8aIhB2jW7zHT6hKP6I2KznRkYOkfiu1Asr+wbb
 UqK6BV1V4FLQzTGxDoFTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:KoXLAHIM9CI=:b8tiTQ5yipXNdQl2Vc6u8d
 OOilbudedLA3A4h+MxuJhxWRvF3YqrD4jAPIuqywXZ01WQI98GzRCFaMCF2z/xb/Gw46UDcVO
 6INBpM8K0Oe0Q//5nNal6iLzuInI91ERWHo1rx0aAiYY5orWhKsHICm8wH4Mg2gCiMJ7u326k
 8wo9sJY1phPN1/ysQT3XrwtA0RhK0WJzdJJ1k89UB9esBj5R0uSMfzfPdj67SWiMNrVtxwpD2
 Qt/pRJK4CDfYHa/cc9CijZ9L0auPlkjapdQsNfL+PG5yE5EDMbjet0oFqAB7pcxt25KJHJapG
 X7EDesa5Euk509ikLWOEjlmQmFLQ0i5yqPk6nqllZR78v8E18LZ8PnuueJcqbC4WkKPs0lRpi
 DDRpSw4CFRjRyh5gvaMAg8uRdtVLvcg6r3yrz01pjE/+VbzJfzVomiw74lGQP4T/v47Thro5P
 HM9ToV45OOxppxmFkaxoEo+yTLimXJn98bKFvPFTFyY67Wl81RYkJ459IMygn7zrHo41hWrSa
 n3RnRxYQF8D0WY0CmHCAZ2umOhxxqnBJa1Y78i4guyC2n2IvwOUflmcYbVHFMwALMCqJfsU4C
 YmaplNJYu8CVz51j+xSBajFwmsMwEebtb619Vp+UWESQAqSELQTSLwxmEAn/LV78xsIJnLwaw
 y661rVosCJ5gze4Qy0TvjdWkKKS2e8uzRnwwZxuMsf5isyqZDOBlokrgBpLb/y5M0vzUayy79
 QbMesXzhD2zMQ/tncFwYfdZaUzQB08VPu5iDwxX8djGtvYYST+cAvhpIFeuLMBokWcUBknM9E
 VkJ29URlCYhBUeMjJp7Q/mdRiZzHW0LFb99anCXWcIKHcTfGjoyvjUWzsb0YE20eXsNF2bwOo
 sE7UHIjokLh/NyvFkUYP4ZHXmfUOZ0Yr9zhblSP7iBw3U/NHYnd1nIkIdbgcC0dkKjx6yzi9e
 0QRnjUdMErt6KNRTX15ElTLmNi19lJ7+d4RsrNex2XEZSgO7PyWF4
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On 5/14/19 4:28 PM, Roman Penyaev wrote:
> On 2019-04-17 23:53, Manuel Bentele wrote:
>
> [cut]
>
>> If you have an idea to solve the opposition for file formats that are
>> acting as a container or virtual disk node for various data, please let
>> me know.
>
> If you need a raw block device you can export qcow2 image as a network
> block
> device, something as the following:
>
> # modprobe nbd
> # qemu-nbd --connect=3D/dev/nbd0 image.qcow2
> # fdisk -l /dev/nbd0
>
> I suppose simplest variant.
>
> --
> Roman

Thanks for your suggestion. We already discussed this during a project
meeting. Some time ago, I have summarized that already (sorry for the
diverging conversation of this topic on the mailinglist).
All in all, the crucial point is the performance:

> [...]
>
> A workaround for that problem could be the local usage of nbd to include
> the QCOW2 disk image as block device, but it involves a lot of
> interaction between user and kernel space and thus an decreasing
> performance. That leads to the motivation to implement the reading of
> QCOW2 disk images directly in the kernel and aim for an merge into the
> mainline kernel source to avoid out-of-kernel-tree maintenance.
>
> [...]

=2D-
Manuel
