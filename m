Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 456DDC07E9C
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 14:42:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2EB7161C37
	for <linux-block@archiver.kernel.org>; Wed,  7 Jul 2021 14:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232082AbhGGOpd convert rfc822-to-8bit (ORCPT
        <rfc822;linux-block@archiver.kernel.org>);
        Wed, 7 Jul 2021 10:45:33 -0400
Received: from mta-tor-003.bell.net ([209.71.212.30]:30552 "EHLO
        cmx-torrgo002.bell.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S232022AbhGGOpd (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 7 Jul 2021 10:45:33 -0400
X-Greylist: delayed 369 seconds by postgrey-1.27 at vger.kernel.org; Wed, 07 Jul 2021 10:45:32 EDT
X-RG-CM-BuS: 0
X-RG-CM-SC: 0
X-RG-CM: Clean
X-Originating-IP: [67.71.147.238]
X-RG-Env-Sender: dave.anglin@bell.net
X-RG-Rigid: 60C8802C00F99E5E
X-CM-Envelope: MS4xfETMKvYBn9Eqc02EI8O+fnIy40QVXZoeIEweaC0ZMFOfoE+lg6IIxLDVfqeOTeDIAJSbir61aSFyqhLUprDE7by0I6G7lU9iZ5t1yOdhUtEk91Tsyr1Z
 YCvX/0B4IOGw0hYm6hz4AepydeKLBrjMfFZSwlO912HVII02toG6+5cEsAG5Qmm/hSgzviF2J/bwAIzwHNZIzMKgvlhMqvcTMUwipCV/O9NPni42eiChsZdL
 1dWxrGiwBr7FppwnGZpoaeP7w/8Y5mO62CUHzWPanWJpc68uAWcr9wEDUXYM5FFm/sOFJE9oKbuKm8fYWytsSbNy9GUO1VCzaXSdRCZkGf5L8CjXwmh2tWa5
 tBFbkYYx8BCyVneejuc+gkFUz7/JGioHwU2v3+flDCow7aoa/Bl13kRj7EIOgGwVmBUJF2EDCKYBRLWHkEJCtUzTN79Dy/GZkhCka4cTTxSIQFrVjZpjwZ98
 d1LHomicS/3TFxDuVqz8Cy+SXGlh/8xaz+puussjSIapU0Qf7/YoI+JFThc=
X-CM-Analysis: v=2.4 cv=Zd5+iuZA c=1 sm=1 tr=0 ts=60e5bbf8
 a=/cPhanApxV8nRKTAyWrE3w==:117 a=/cPhanApxV8nRKTAyWrE3w==:17
 a=IkcTkHD0fZMA:10 a=mDV3o1hIAAAA:8 a=FBHGMhGWAAAA:8 a=Exa40m6Ew_gtj0IxAc0A:9
 a=QEXdDO2ut3YA:10 a=_FVE-zBwftR9WsbkzFJk:22 a=9gvnlMMaQFpL9xblJ6ne:22
Received: from [192.168.2.49] (67.71.147.238) by cmx-torrgo002.bell.net (5.8.716.03) (authenticated as dave.anglin@bell.net)
        id 60C8802C00F99E5E; Wed, 7 Jul 2021 10:36:40 -0400
To:     Arnd Bergmann <arnd@arndb.de>,
        Abd-Alrhman Masalkhi <abd.masalkhi@gmail.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Jens Axboe <axboe@kernel.dk>, bernie@develer.com,
        Parisc List <linux-parisc@vger.kernel.org>,
        linux-block <linux-block@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>
References: <CAK8P3a2mAQOnTxBhVzVA8q8O-uVrdidCN5h5-T2dc0=Wet2uPQ@mail.gmail.com>
 <20210706205927.4407-1-abd.masalkhi@gmail.com>
 <CAK8P3a23=tcWx8iWNAKXcT9TRgPrZbEVVy9a_ad29hSde_jkKg@mail.gmail.com>
From:   John David Anglin <dave.anglin@bell.net>
Subject: Re: div_u64/do_div stack size usage, was Re: [v3] block: Removed a
 warning while compiling with a cross compiler for parisc
Message-ID: <f9293c4d-bb4e-bcf0-183e-90cf5192a725@bell.net>
Date:   Wed, 7 Jul 2021 10:36:38 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a23=tcWx8iWNAKXcT9TRgPrZbEVVy9a_ad29hSde_jkKg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 2021-07-07 4:17 a.m., Arnd Bergmann wrote:
> I have also tried it with the other gcc versions and shown that it
> happens with every older compiler as well, but it does not happen
> with gcc-10 or gcc-11, which bring the frame size down to 164 or
> 172 bytes respectively. gcc-10 also fixes similar warnings for
> net/ipv4/tcp_input.c, net/sunrpc/stats.c and lib/xxhash.c that
> fly under the radar with the default warning level.
>
> My first thought was this was a result of -finline-functions getting
> enabled by default in gcc-10, but enabling it on gcc-9 did not
> help here. It's likely that the gcc behavior was fixed in the process
> of enabling the more aggressive inliner by default though.
A number of improvements were made to the calculation of RTX costs in gcc-10 and gcc-11.
These dramatically affect inlining and the compilation time for xxhash.c on parisc.  The problem
is pretty much fixed for the 32-bit target but more work is needed for the 64-bit target.

See:
https://gcc.gnu.org/bugzilla/show_bug.cgi?id=87256

Dave

-- 
John David Anglin  dave.anglin@bell.net


