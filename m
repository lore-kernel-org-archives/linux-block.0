Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:64062 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934051AbeFYRFm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Jun 2018 13:05:42 -0400
Subject: Re: [PATCH blktests 00/15] Add SRP initiator driver tests
To: Ming Lei <tom.leiming@gmail.com>
Cc: Omar Sandoval <osandov@fb.com>,
        linux-block <linux-block@vger.kernel.org>,
        Ming Lei <ming.lei@redhat.com>
References: <20180622221946.10987-1-bart.vanassche@wdc.com>
 <CACVXFVMUNWPniJH7Zcw=xC0xb=uRPtgEE_Qh=4xfUUQ-EG4NTQ@mail.gmail.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
Message-ID: <217335ac-80ab-fce1-8ba5-6dce11f5cef4@wdc.com>
Date: Mon, 25 Jun 2018 10:05:41 -0700
MIME-Version: 1.0
In-Reply-To: <CACVXFVMUNWPniJH7Zcw=xC0xb=uRPtgEE_Qh=4xfUUQ-EG4NTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

On 06/22/18 20:15, Ming Lei wrote:
> Just tried srp/001
> 
> [root@ktest-04 blktests]# ./check srp/001
> srp/001 (Create and remove LUNs)                             [failed]
>      runtime  0.912s  ...  18.358s
>      --- tests/srp/001.out 2018-06-23 02:41:33.267925950 +0000
>      +++ results/nodev/srp/001.out.bad 2018-06-23 03:11:30.062799405 +0000
>      @@ -1,8 +1,27 @@
>      -Unloaded the ib_srpt kernel module
>      +Unloaded the ib_srp kernel module
>      +modprobe: FATAL: Module target_core_mod is in use.
>      +modprobe: FATAL: Module target_core_mod is in use.
>      +modprobe: FATAL: Module target_core_mod is in use.
>      +modprobe: FATAL: Module target_core_mod is in use.
>      +modprobe: FATAL: Module target_core_mod is in use.
>      ...
>      (Run 'diff -u tests/srp/001.out results/nodev/srp/001.out.bad' to
> see the entire diff)
> 
> [root@ktest-04 blktests]# lsmod | grep target
> iscsi_target_mod      303104  1 ib_isert
> target_core_mod       356352  2 iscsi_target_mod,ib_isert

LIO must be unconfigured before the SRP tests are run. The above output 
shows that LIO was already loaded before the SRP tests were started. I 
will add a test that prevents the SRP tests to start if LIO was already 
configured.

Bart.
