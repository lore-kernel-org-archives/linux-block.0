Return-Path: <SRS0=UGhi=5B=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17883C0044D
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 15:22:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD93220663
	for <linux-block@archiver.kernel.org>; Mon, 16 Mar 2020 15:22:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KGPOxEPE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731375AbgCPPWu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Mar 2020 11:22:50 -0400
Received: from mail-wr1-f67.google.com ([209.85.221.67]:38839 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729541AbgCPPWu (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Mar 2020 11:22:50 -0400
Received: by mail-wr1-f67.google.com with SMTP id s1so12879wrv.5
        for <linux-block@vger.kernel.org>; Mon, 16 Mar 2020 08:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UEFSuIJWSeXvXrFC+2FSAUgO6FCfebtTsgK6H2HY/vs=;
        b=KGPOxEPEebtSVJD97lWSecsmdDteakaBStX5L53Ha3KRWM0SsfEJmvOl/xo/mpz8dJ
         voQMoLwGfC8A1zAXe40yWjLw/CdtqnfV/IJ/wlctsWP5ldUu3cCTwMPXcdgu4+rm6KtK
         ZYV3rxKMhO/tOHbWVgy3LDHqqseWDbDuo2fS1tiBjfipGEyK7ylQnN3IHfHdt4WWhuFn
         Jt1tu9xpbxp0GLxRXOuoPeBSGb0gcrhlOPj9sKrcnKaS+znLprt6V7ymdf9EKj3F235C
         AqFSni/56mXnW5g2elv3OwDTZ04aBi7M4y2gKd1EJ4wuSoP2vw8el67zeEdi/wu95RYR
         NqrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UEFSuIJWSeXvXrFC+2FSAUgO6FCfebtTsgK6H2HY/vs=;
        b=tbpyDu+aGo6C2RVBOyBU9rPgOYD3vkWAoLztyot0LCUX7oSi5syEXkZHT2oK7FGSFy
         9X8FTQEF3L0P8O9KJVrjxoiBHPJpsfglI1CDf3/jWO/GyXLt1BgWiHtS8VSbIzwrxfT0
         yi82LV1plZAg5FeYkhB64tHEVHHrkkUfY46mBOYffwf9iwfbr8xuKdJFONUpoax8sp8a
         BRwWF1uMOOIDyGmZRhe6Wckmc/weu2MWJOhIVWq49eBljLw68xL4aSISmfuYfBo/Y5C4
         zKf1IxzCXjq+sN2UDBG16Jpwa+/1XXrve28q17QtqVBSw5NNO5bi+q0GB3yeux47e1H2
         5kHQ==
X-Gm-Message-State: ANhLgQ0gKNnCbwCbaPNvKzTQKRKL+O1xug8K+OC/uhAzchGYwSl7iC+4
        RMdk5Wx3YpTDHQpqK7h8ckk1s3ZCuUUt5agdVH0=
X-Google-Smtp-Source: ADFU+vsjVRwq3mpDv2WoNalmjtcNrn1cRKLtq916sRYVdh4U1d37BuleRv0jbxHDrGeYcDrn481Mw+y/sUXB2TPTkZY=
X-Received: by 2002:adf:ea88:: with SMTP id s8mr7616818wrm.124.1584372167171;
 Mon, 16 Mar 2020 08:22:47 -0700 (PDT)
MIME-Version: 1.0
References: <CAEK8JBBSqiXPY8FhrQ7XqdQ38L9zQepYrZkjoF+r4euTeqfGQQ@mail.gmail.com>
 <20200312123415.GA7660@ming.t460p> <CAEK8JBAiBwghR5hXiDPETx=EGNi=OTQQz7DOaSXd=96QkUWTGg@mail.gmail.com>
 <20200313023156.GB27275@ming.t460p> <CAEK8JBCHKbBoXutE5rtxA+kUeoCZB2o=Lsjf9WbYZ+sLayNymA@mail.gmail.com>
In-Reply-To: <CAEK8JBCHKbBoXutE5rtxA+kUeoCZB2o=Lsjf9WbYZ+sLayNymA@mail.gmail.com>
From:   Ming Lei <tom.leiming@gmail.com>
Date:   Mon, 16 Mar 2020 23:22:35 +0800
Message-ID: <CACVXFVPJcO41a-dinfEhLKnJ6P=6sMXyg7SZcXPtqHcyqRPUUA@mail.gmail.com>
Subject: Re: [Question] IO is split by block layer when size is larger than 4k
To:     Feng Li <lifeng1519@gmail.com>
Cc:     Ming Lei <ming.lei@redhat.com>,
        linux-block <linux-block@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000037832f05a0fa6485"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

--00000000000037832f05a0fa6485
Content-Type: text/plain; charset="UTF-8"

On Sun, Mar 15, 2020 at 9:34 AM Feng Li <lifeng1519@gmail.com> wrote:
>
> Hi Ming,
> This is my cmd to run qemu:
> qemu-2.12.0/x86_64-softmmu/qemu-system-x86_64 -enable-kvm -device
> virtio-balloon -cpu host -smp 4 -m 2G -drive
> file=/root/html/fedora-10g.img,format=raw,cache=none,aio=native,if=none,id=drive-virtio-disk1
> -device virtio-blk-pci,scsi=off,drive=drive-virtio-disk1,id=virtio-disk1,bootindex=1
> -drive file=/dev/sdb,format=raw,cache=none,aio=native,if=none,id=drive-virtio-disk2
> -device virtio-blk-pci,scsi=off,drive=drive-virtio-disk2,id=virtio-disk2,bootindex=2
> -device virtio-net,netdev=nw1,mac=00:11:22:EE:EE:10 -netdev
> tap,id=nw1,script=no,downscript=no,ifname=tap0 -serial mon:stdio
> -nographic -object
> memory-backend-file,id=mem0,size=2G,mem-path=/dev/hugepages,share=on
> -numa node,memdev=mem0 -vnc 0.0.0.0:100 -machine usb=on,nvdimm -device
> usb-tablet -monitor unix:///tmp/a.socket,server,nowait -qmp
> tcp:0.0.0.0:2234,server,nowait
>
> OS image is Fedora 31. Kernel is 5.3.7-301.fc31.x86_64.
>
> The address from virio in qemu like this:
> ========= size: 262144, iovcnt: 64
>       0: size: 4096 addr: 0x7fffc83f1000
>       1: size: 4096 addr: 0x7fffc8037000
>       2: size: 4096 addr: 0x7fffd3710000
>       3: size: 4096 addr: 0x7fffd5624000
>       4: size: 4096 addr: 0x7fffc766c000
>       5: size: 4096 addr: 0x7fffc7c21000
>       6: size: 4096 addr: 0x7fffc8d54000
>       7: size: 4096 addr: 0x7fffc8fc6000
>       8: size: 4096 addr: 0x7fffd5659000
>       9: size: 4096 addr: 0x7fffc7f88000
>       10: size: 4096 addr: 0x7fffc767b000
>       11: size: 4096 addr: 0x7fffc8332000
>       12: size: 4096 addr: 0x7fffb4297000
>       13: size: 4096 addr: 0x7fffc8888000
>       14: size: 4096 addr: 0x7fffc93d7000
>       15: size: 4096 addr: 0x7fffc9f1f000
>
> They are not contiguous pages, so the pages in bvec are not continus
> physical pages.
>
> I don't know how to dump the bvec address in bio without recompiling the kernel.

I just run similar test on 5.3.11-100.fc29.x86_64, and the observation
is similar with
yours.

However, not observe similar problem in 5.6-rc kernel in VM, maybe kernel config
causes the difference.

BTW, I usually use the attached bcc script to observe bvec pages, and you may
try that on upstream kernel.

Thanks,
Ming

--00000000000037832f05a0fa6485
Content-Type: text/x-python; charset="US-ASCII"; name="bvec_avg_pages.py"
Content-Disposition: attachment; filename="bvec_avg_pages.py"
Content-Transfer-Encoding: base64
Content-ID: <f_k7um7pqz0>
X-Attachment-Id: f_k7um7pqz0

IyEvdXNyL2Jpbi9weXRob24zCiMKIyBidmVjX3BhZ2VzLnB5CiMKIyBXcml0dGVuIGFzIGEgYmFz
aWMgZXhhbXBsZSBvZiBhIGZ1bmN0aW9uIHBhZ2VzIHBlciBidmVjIGRpc3RyaWJ1dGlvbiBoaXN0
b2dyYW0uCiMKIyBVU0FHRTogYnZlY19wYWdlcwojCiMgVGhlIGRlZmF1bHQgaW50ZXJ2YWwgaXMg
NSBzZWNvbmRzLiBBIEN0cmwtQyB3aWxsIHByaW50IHRoZSBwYXJ0aWFsbHkKIyBnYXRoZXJlZCBo
aXN0b2dyYW0gdGhlbiBleGl0LgojCiMgQ29weXJpZ2h0IChjKSAyMDE2IE1pbmcgTGVpCiMgTGlj
ZW5zZWQgdW5kZXIgdGhlIEFwYWNoZSBMaWNlbnNlLCBWZXJzaW9uIDIuMCAodGhlICJMaWNlbnNl
IikKIwojIDE1LUF1Zy0yMDE1CU1pbmcgTGVpCUNyZWF0ZWQgdGhpcy4KCmZyb20gYmNjIGltcG9y
dCBCUEYKZnJvbSBjdHlwZXMgaW1wb3J0IGNfdXNob3J0LCBjX2ludCwgY191bG9uZ2xvbmcKZnJv
bSB0aW1lIGltcG9ydCBzbGVlcApmcm9tIHN5cyBpbXBvcnQgYXJndgppbXBvcnQgb3MKCiMgZGVm
aW5lIEJQRiBwcm9ncmFtCmJwZl90ZXh0ID0gIiIiCiNpbmNsdWRlIDx1YXBpL2xpbnV4L3B0cmFj
ZS5oPgojaW5jbHVkZSA8bGludXgvYmxrZGV2Lmg+CgpzdHJ1Y3Qga2V5X3QgewogICAgdW5zaWdu
ZWQgZGV2X25vOwp9OwoKc3RydWN0IHZhbF90IHsKICAgIHU2NCBidmVjX2NudDsKICAgIHU2NCBz
aXplOwogICAgdTY0IGJpb19jbnQ7Cn07CgpCUEZfSEFTSChidmVjLCBzdHJ1Y3Qga2V5X3QsIHN0
cnVjdCB2YWxfdCk7CgovLyB0aW1lIGJsb2NrIEkvTwppbnQgdHJhY2Vfc3VibWl0X2JpbyhzdHJ1
Y3QgcHRfcmVncyAqY3R4LCBzdHJ1Y3QgYmlvICpiaW8pCnsKICAgIHVuc2lnbmVkIHNob3J0IHZj
bnQ7CiAgICB1bnNpZ25lZCBzaXplOwoKICAgIHNpemUgPSBiaW8tPmJpX2l0ZXIuYmlfc2l6ZTsK
ICAgIHZjbnQgPSBiaW8tPmJpX3ZjbnQ7CgogICAgaWYgKHZjbnQpIHsKICAgICAgICBzdHJ1Y3Qg
dmFsX3QgKnZhbHA7CiAgICAgICAgc3RydWN0IGtleV90IGtleTsKICAgICAgICBzdHJ1Y3QgdmFs
X3QgemVybyA9IHswfTsKCiNpZiBMSU5VWF9WRVJTSU9OX0NPREUgPj0gS0VSTkVMX1ZFUlNJT04o
NCwgMTQsIDApCiAgICAgICAgaW50IG1haiwgbWluOwoKICAgICAgICBtYWogPSBiaW8tPmJpX2Rp
c2stPm1ham9yOwogICAgICAgIG1pbiA9IGJpby0+YmlfZGlzay0+Zmlyc3RfbWlub3I7CiAgICAg
ICAga2V5LmRldl9ubyA9ICh1bnNpZ25lZClNS0RFVihtYWosIG1pbik7CiNlbHNlCiAgICAgICAg
a2V5LmRldl9ubyA9ICh1bnNpZ25lZCliaW8tPmJpX2JkZXYtPmJkX2RldjsKI2VuZGlmCiAgICAg
ICAgdmFscCA9IGJ2ZWMubG9va3VwX29yX2luaXQoJmtleSwgJnplcm8pOwogICAgICAgIHZhbHAt
PmJ2ZWNfY250ICs9IHZjbnQ7CiAgICAgICAgdmFscC0+c2l6ZSArPSBzaXplOwogICAgICAgIHZh
bHAtPmJpb19jbnQgKz0gMTsKICAgIH0KCiAgICAvL2JwZl90cmFjZV9wcmludGsoInBhZ2VzICVk
LCB2Y250OiAlZFxcbiIsIHNpemU+PjEyLCB2Y250KTsKCiAgICByZXR1cm4gMDsKfQoKIiIiCgoj
IGxvYWQgQlBGIHByb2dyYW0KYiA9IEJQRih0ZXh0PWJwZl90ZXh0KTsKYi5hdHRhY2hfa3Byb2Jl
KGV2ZW50PSJzdWJtaXRfYmlvIiwgZm5fbmFtZT0idHJhY2Vfc3VibWl0X2JpbyIpCgojIGhlYWRl
cgpwcmludCgiVHJhY2luZy4uLiBIaXQgQ3RybC1DIHRvIGVuZC4iKQoKIyBvdXRwdXQKdHJ5Ogog
ICAgc2xlZXAoOTk5OTk5OTkpCmV4Y2VwdCBLZXlib2FyZEludGVycnVwdDoKICAgIHBhc3MKCnBh
Z2Vfc2l6ZSA9IG9zLnN5c2NvbmYoIlNDX1BBR0VfU0laRSIpCnByaW50KCJcbiUtN3MgJS0xMnMg
JTEycyAlMTJzIiAlICgiREVWSUNFIiwgIlBBR0VTX1BFUl9CVkVDIiwgIlNJWkVfUEVSX0JJTyIs
ICJWQ05UX1BFUl9CSU8iKSkKY291bnRzID0gYi5nZXRfdGFibGUoImJ2ZWMiKQpmb3IgaywgdiBp
biBjb3VudHMuaXRlbXMoKToKICAgIHBncyA9IHYuc2l6ZSAvIHBhZ2Vfc2l6ZQogICAgcHJpbnQo
IiUtM2Q6JS0zZCAlLTEyZCAlMTJkS0IgJTEyZCIgJSAoay5kZXZfbm8gPj4gMjAsIGsuZGV2X25v
ICYgKCgxIDw8IDIwKSAtIDEpLCBwZ3MgLyB2LmJ2ZWNfY250LCAodi5zaXplID4+IDEwKSAvIHYu
YmlvX2NudCwgdi5idmVjX2NudCAvIHYuYmlvX2NudCkpCgo=
--00000000000037832f05a0fa6485--
