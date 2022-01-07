Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C94FC433F5
	for <linux-block@archiver.kernel.org>; Fri,  7 Jan 2022 02:31:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345402AbiAGCbE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 6 Jan 2022 21:31:04 -0500
Received: from mout.gmx.net ([212.227.17.22]:60611 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1345392AbiAGCbE (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 6 Jan 2022 21:31:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1641522661;
        bh=qbXL3q/1u8jUtLvDNJiSLgKfHPydeo3BlrhfPtIUxvE=;
        h=X-UI-Sender-Class:Date:To:From:Subject;
        b=O2mKhHU5jkWlarAW0lUJihJ/cWSKU2wMQawGhApk9u9bMkviD1oVe/HN1oub2fRyA
         h7BgDQd16CVYYUiYlXnGrTJxildnwwX7QJRFn2vAcGO6jZ0nanu3y4yfyV6NNrU9XT
         W4xoQH7YRNpJYRF7HynpTMBE27TUzxzNzAApxqa4=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [0.0.0.0] ([149.28.201.231]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MGQj7-1nAs5h15Th-00Gti1; Fri, 07
 Jan 2022 03:31:01 +0100
Message-ID: <0535d6c3-dec3-fb49-3707-709e8d26b538@gmx.com>
Date:   Fri, 7 Jan 2022 10:30:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>
From:   Qu Wenruo <quwenruo.btrfs@gmx.com>
Subject: Proper way to test RAID456?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:kphmq0FEyg7Wx9XOgZDjRrSzWN242v/TGFEZ+QKFhrInxyqw1jv
 0RBpSjIXo2rzYMDTqIQE5LtmdvKNuC1Q/y6uIGM1e5+/2xd1E5KEn9oWNKrysxwwGW3rOBl
 640Msj/jcUo/VmIrP5VA0THSNyEWF1EbDc7xCrj8sFP1BKR2CdwSXX3nZC0owYPEtwP5c69
 yQIqwNtN8wLoPUIRLOBpQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:WAV2ONlsCUA=:LxY7Ga4tvO+a/q7NmLyBXw
 w6MzyDLBLjmVMKdfO08JW61KyXhtI4PSa3KhOjrROW6PqAA2uHVcwQENA6NrGzex6wwv10+Fc
 42HO7K+1nr2tlnH5YXUYe/7tR5BB4yDfAq1gc7NqMCWxLYkiWDCC9kPgTwD6qyfGBYVeL+uh9
 NRsporstUTKNNO8BCBZKG4DhE9MqTNwwKScmapvFCM4blktdm3zj6PaUGZGgn9uNGtIvTtoJV
 USczmyxVQdGDcrUk7ZELqjz+mk05oTgkWhgWfE1IdVXl+njrlGp+oUdWiMIkeebgMT2xtx//F
 nmHHtNTCF1XO+imz2iEXZ0iD5gcQfMGQuscBcsBsuXUS6GNHPWM605dPJM+5PCcm72YDOM4ZZ
 LJ8AHh2OzyNDxOIA/mKLwtfF2KhHH2ZrjIUIbvtJpJTdZC0IaM56ptzJPwKC41B1H+Z0A6KP0
 UiKmiVEwqsXoPweGyBjAxEt4rAckzT2QYpzZQeo4VS1oyVuWX5xJo9us8MX1wqu3183ZV0lMU
 dXn32Hb/+xS+z0CrFgaIGjG83c/4+9HjT/iCV0vuyemyNqfY1ddroOkMueNM5oMPDqi9n6/Zh
 kbvuvTYreeGW4I7NUaDusgGDeTFZ9bE/VpST+K3oBMu8Gd+78cikQl35rRGvwkiYb0TqXmDKk
 2DIvqzxwuQz2dM7QF0M/VkmboJ/eMhiVb9GK/Pvjcepk/FKPNFXWMumJKIsVTleF1rhBv7kVr
 Nyjm9lPeoh3jXlbnN2p7tp//4DJxIRO4ia2UabpDHopCh3CYGLR5yWkhRqIuuLQhEFlLJBDGa
 LtlxWq6f/75L7gaRfP/nnr5NAsZkT/DNa2pg6Qr82hXIGOt9LvIeUMXnh98Wvuk1MO1/UNqqU
 /Dpz64X9QsTtc2d/NPZphVgd8/gOBfqPW+ihIU1nfqxmV4FX/rPww0RHFSrzwp31ZQEvHAYh0
 rd43astCnN8bwj+QjoIEXBZFTHrRyoDVaJ3iPdKlABT/w/97+PJyXLSJ2lMeasZykvF4xbDLq
 vaZJsYDyM97Ef7vWekTlCONC6DUmRruuMH4T7bYcEWjKBgPBNdk/GrEQlQSoj+I0t5egMD8gq
 VYEQqu7IXqLBx8=
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

Recently I'm working on refactor btrfs raid56 (with long term objective
to add proper journal to solve write-hole), and the coverage of current
fstests for btrfs RAID56 is not that ideal.

Is there any project testing dm/md RAID456 for things like
re-silvering/write-hole problems?

And how you dm guys do the tests for stacked RAID456?

I really hope to learn some tricks from the existing, tried-and-true
RAID456 implementations, and hopefully to solve the known write-hole
bugs in btrfs.

Thanks,
Qu
