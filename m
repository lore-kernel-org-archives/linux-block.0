Return-Path: <SRS0=Ij7C=UE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 809B9C28CC5
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 20:56:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5401E2067C
	for <linux-block@archiver.kernel.org>; Wed,  5 Jun 2019 20:56:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726543AbfFEU4O (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 5 Jun 2019 16:56:14 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:42825 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfFEU4O (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 5 Jun 2019 16:56:14 -0400
Received: from [192.168.1.110] ([77.2.1.21]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1Mi2Bb-1gvSdm3T97-00e4xP; Wed, 05 Jun 2019 22:55:55 +0200
Subject: Re: [PATCH] block: Drop unlikely before IS_ERR(_OR_NULL)
To:     Joe Perches <joe@perches.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Pravin B Shelar <pshelar@ovn.org>,
        Anton Altaparmakov <anton@tuxera.com>,
        "David S. Miller" <davem@davemloft.net>
References: <20190605142428.84784-1-wangkefeng.wang@huawei.com>
 <20190605142428.84784-4-wangkefeng.wang@huawei.com>
 <8221bc17-b0bb-da6f-4343-3e73467252d5@metux.net>
 <44c945bf0573842fe9b2db89407e40c88fcc7eb4.camel@perches.com>
From:   "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <ecd9df60-f4e2-108d-43ae-fbdf5721471e@metux.net>
Date:   Wed, 5 Jun 2019 20:55:48 +0000
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <44c945bf0573842fe9b2db89407e40c88fcc7eb4.camel@perches.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:OpvBXb21v9xeH3z9JI5aCc/P+EN+TrdONa8z2f/P3LsFhfCDDpo
 eMl0KdkjQqe+gWvbfkvHdlgt/ljGPl/u6T/bbgxOe/pBTJPfczz1YV9iw+BQFYH9tRQte/F
 XPUt0tNhWh6CQ8qYM086YNCYfhfx4+z1euF9Z4oPUTWgpYeTM2ojHjfjWGvsKeZXT58bbYz
 1GPLexop3kE/7mHRopbrA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:iwK6QWV4If4=:r3jvpSCN+4Ob0dg+Pbdn1A
 x4zuU4mUhTjSR3HY9p7IfXeoWZqpMwlH86MD1BS4whiI7zEy9hi8po186dQAtjbujp441uKol
 O7jKVHOwrBaFPuVAn+5DHMFS63YmsqxQHGpYiBR3rSh9FWXOvTQkCTRYMBKjQk1ABqiYcM+1H
 MPsaOlTVYAxWp5GmYulzhvxfUcQb+uTQw5SEd1BckGQfwjcPNqwiJmjhJSmHCflJIV1uevNLi
 +2RSQj0mpoiMDc7rztarOA4DWPbcazKvHWDbnLnP8rfd/tezmU5/Pge04sRmoWXPaMm6fEIIj
 bIkCf9sRNw+6yswO+QmDp8wT7m59aL3kNbgukPeYgZ3WzXNW9qHWPLVYvIFlSstuUKtgH6UL3
 xRRqYRY11S2+w2sCOp5MevLCJljJJWJYWW5plQd2uvI4rkwaKr3wxt7BjxWVH8tDzog6u05HG
 6yB+7AZe7a4QHfWT8LlBfKHmZiRrm2idTFUTkUorOPXA6gAkBNPyM7VrLR0Efv6tHiAkIcnP8
 ND/Tfu9XzH1R4YyZ/9EWfp/Axwp1OOsnTX/vSIK/AnLe4TsdDNF/wkZ35jghundG5IoQhV0op
 6OpOVx3/+5sYzyGgWUt4Um9Hrr1Y1mo7yX6qnfWRDY8pl93fTY/WDuFCgibrRl/B+lvRrq2bJ
 Jj+Udsrs4VcU1jQlYtapkCkMsYyl7uxNTysCnK67LzEJhG1d/NDqG40m05Cwpiu/0UoyJfJQX
 P3gYO5eXgU7pejcuir0sIoN8SqPjcDZHJnxEE/2JUlJZ3Eurir8gKUdTubA=
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On 05.06.19 18:32, Joe Perches wrote:

> Likely change all of these too:
> 
> $ git grep -P '\blikely.*IS_ERR'
> drivers/net/vxlan.c:    if (likely(!IS_ERR(rt))) {
> fs/ntfs/lcnalloc.c:     if (likely(page && !IS_ERR(page))) {
> fs/ntfs/mft.c:  if (likely(!IS_ERR(page))) {
> fs/ntfs/mft.c:  if (likely(!IS_ERR(m)))
> fs/ntfs/mft.c:          if (likely(!IS_ERR(m))) {
> fs/ntfs/mft.c:          if (likely(!IS_ERR(rl2)))
> fs/ntfs/namei.c:                if (likely(!IS_ERR(dent_inode))) {
> fs/ntfs/runlist.c:      if (likely(!IS_ERR(old_rl)))
> net/openvswitch/datapath.c:             if (likely(!IS_ERR(reply))) {
> net/socket.c:   if (likely(!IS_ERR(newfile))) {

Good point, thx.

Added that to my cocci script, which I've just sent to lkml.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
