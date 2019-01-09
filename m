Return-Path: <SRS0=RPGG=PR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D90ECC43387
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 06:54:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B28C214C6
	for <linux-block@archiver.kernel.org>; Wed,  9 Jan 2019 06:54:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iABypqlh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbfAIGyq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 01:54:46 -0500
Received: from mail-vs1-f43.google.com ([209.85.217.43]:39675 "EHLO
        mail-vs1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728661AbfAIGyp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 01:54:45 -0500
Received: by mail-vs1-f43.google.com with SMTP id h78so4108068vsi.6;
        Tue, 08 Jan 2019 22:54:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=irgl0E1KjhyJdmcuMDnvBea7Qv8resZaJHxnJN0Zmis=;
        b=iABypqlhmFqb7YQ41rq0eXx5YYCWrHwueh3RAMvnWvwsJiTAZ4ATwYf6ZaH7ETsWLU
         HXdZvYGrVLmmA9KM0pGF75xPOYwa5QqjrbbmJnSlIfxQnMfRkqpGzEoGFUeAUe1TVziA
         SosmFmDivkfmcz5qaUksbM7T/49qFqwlOh572AJe5wpZxCMDZ9MFiumrVyJNYG/t6D71
         Kjm/SqiQBUwmz6EHTHqaF3DxmukAXFAroS+aOCfWCbt5ZJ9+CeYZBZ3PsocpTZaHfdck
         P1lZWbhtGKj9P8h1yMTnrCvPgOseEKO+j2gfR/D65+BhVORXkSicFYaAU/Lu/rOZxsb6
         yyHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=irgl0E1KjhyJdmcuMDnvBea7Qv8resZaJHxnJN0Zmis=;
        b=DqaE6FhcRsBL7/IXXwqsFROUbW9Ao1sHeRbv9/a/pOWT2HzVaDRDmTjSpOd3dJkfht
         N6QC1o4SBYCWztIowv/7V6KKnpTYN5Zx23wUFg0ZL4ncT+/nfEL7D6xIZLH9KrH43PYy
         w0wU8AD8O8sXTimi0VJ8EXZlpoo/n0Us+c6mmcOKbGLUNSuP+P8YAQlVEqNSMe0zKfiZ
         yZThPAp32chOcs0vwHQJDeqdMyq10r6Ryy4lLlMM1u9bbJNmgzmPE0MmhN9d36DJbQPY
         SJ9eeVrRqFMARQlhWvLchxbMPyjhZ0q+t4lD254fWGlrqmoYen33feO2Fj6b/Xu+equS
         555Q==
X-Gm-Message-State: AJcUukcRSwicco7zfFs5WNAH5luDiZ3b32XoFmDyb4tS6Gj4HSBbAiBa
        32P8vPVHGfI55d8wP9nkw2Ma8z12B4yEFD4+c8M=
X-Google-Smtp-Source: ALg8bN5e2H5Z7x7MyYMQBkjUpCGRX8XQQdPGOdgHaHDwikOgWFxGZ0UMAagzAmZBbc3JLnpVRq/o9XuBRTlLE2Rb2sU=
X-Received: by 2002:a67:8513:: with SMTP id h19mr1942218vsd.91.1547016883781;
 Tue, 08 Jan 2019 22:54:43 -0800 (PST)
MIME-Version: 1.0
References: <CALjAwxgOhbYF=A4PbVipP9M+XnwnRG+c2Pcid=cZjtBe0uDUHw@mail.gmail.com>
 <CALjAwxj8LHFomCJJNCDmne1PZ6ygjtzKyvA+09kQA62vQZ3OBA@mail.gmail.com>
 <1546445424.29282.1.camel@redhat.com> <1546540117.24199.0.camel@redhat.com>
 <1546548458.24199.2.camel@redhat.com> <CALjAwxhOb_HLD1Adux-n0LUienLK_FhrOnyBw=UMLj49aN6_5A@mail.gmail.com>
 <1546555220.2666.1.camel@redhat.com> <CALjAwxgtCGLEJkV3xw4Amp4gdkuacgmTVkYn=w8ZHucJ6ffDew@mail.gmail.com>
 <4c231a3e-1ae3-c872-f6f8-06b19ddfd20b@suse.de> <CALjAwxiaVRpqgxs4rtjxDM4J5YDnrKAyCwn79h5tdhxwZX8iTA@mail.gmail.com>
 <b7ab94d7-8282-425a-3dcd-38a538a44d24@suse.de> <CALjAwxjaffzBMSEC=R1ftW1upb2LZWuYinOxORGGUU9THm4vbA@mail.gmail.com>
In-Reply-To: <CALjAwxjaffzBMSEC=R1ftW1upb2LZWuYinOxORGGUU9THm4vbA@mail.gmail.com>
From:   Sitsofe Wheeler <sitsofe@gmail.com>
Date:   Wed, 9 Jan 2019 06:54:37 +0000
Message-ID: <CALjAwxgt_r46a5dr0U4AnRTNh0AtjRyY-Nr8e0aofaJzr4SC_A@mail.gmail.com>
Subject: Re: failed command: WRITE FPDMA QUEUED with Samsung 860 EVO
To:     Hannes Reinecke <hare@suse.de>
Cc:     Laurence Oberman <loberman@redhat.com>, linux-ide@vger.kernel.org,
        linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Tue, 8 Jan 2019 at 07:06, Sitsofe Wheeler <sitsofe@gmail.com> wrote:
>
> > As for the NCQ issues: it might be that the adapter has issues with NCQ
> > (quite some older adapters do).
> > It might also be a problem with the _previous_ command which failed; can
> > you enable libata tracing to figure out the command flow?
>
> OK I'll see if I can get around to this one tomorrow.

So I wound up attempting this from an Ubuntu 18.04.1 live cd (because
I was trying to minimize background disk usage). I deactivated
LVM/VG/mdadm devices before running the test (lvchange -a n ...;
vgchange -a n ...; mdadm --stop ...).

Kernel:
Linux ubuntu-server 4.15.0-29-generic #31-Ubuntu SMP Tue Jul 17
15:39:52 UTC 2018 x86_64 x86_64 x86_64 GNU/Linux

Tracing setup (I don't know if this is correct - googling around for
"enable libata tracing" only turned up
https://github.com/torvalds/linux/blob/master/drivers/ata/libata-trace.c
which doesn't contain an example):
echo "libata*" > /sys/kernel/debug/tracing/set_ftrace_filter
echo 1 > /sys/kernel/debug/tracing/events/libata/enable

Clear dmesg and any tracing:
dmesg -C
echo "" > /sys/kernel/debug/tracing/trace

<Some fiddling around with apt/apt config to fetch down a copy of fio>

fio command used:
fio --readonly --name --rw=randread --filename /dev/sdb --bs=32k
--ioengine=libaio --iodepth=16 --direct=1 --runtime=20s --time_based
--max_latency=100ms
(this is so that fio quits when the latency becomes high due to the bus resets)

After fio exits:
dmesg
less  /sys/kernel/debug/tracing/trace

dmesg looks like this:
[ 2427.105459] ata2.00: exception Emask 0x0 SAct 0x7fffffff SErr 0x0 action 0x6
[ 2427.105465] ata2.00: irq_stat 0x40000008
[ 2427.105472] ata2.00: failed command: READ FPDMA QUEUED
[ 2427.105486] ata2.00: cmd 60/40:68:40:c1:00/00:00:00:00:00/40 tag 13
ncq dma 32768 in
                        res 41/84:40:40:c1:00/00:00:00:00:00/00 Emask
0x410 (ATA bus error) <F>
[ 2427.105490] ata2.00: status: { DRDY ERR }
[ 2427.105493] ata2.00: error: { ICRC ABRT }
[ 2427.105503] ata2: hard resetting link
[ 2427.576563] ata2: SATA link up 1.5 Gbps (SStatus 113 SControl 310)
[ 2427.576992] ata2.00: supports DRM functions and may not be fully accessible
[ 2427.581186] ata2.00: supports DRM functions and may not be fully accessible
[ 2427.584783] ata2.00: configured for UDMA/33
[ 2427.584857] ata2: EH complete
[ 2427.585742] ata2.00: Enabling discard_zeroes_data

The start of the trace file looks like this:
# tracer: function
#
#                              _-----=> irqs-off
#                             / _----=> need-resched
#                            | / _---=> hardirq/softirq
#                            || / _--=> preempt-depth
#                            ||| /     delay
#           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
#              | |       |   ||||       |         |
             fio-4212  [001] d...  2426.910197: ata_qc_issue:
ata_port=2 ata_dev=0 tag=15 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:78:00:00:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.910267: ata_qc_issue:
ata_port=2 ata_dev=0 tag=16 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:80:40:00:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.910320: ata_qc_issue:
ata_port=2 ata_dev=0 tag=17 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:88:80:00:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.910378: ata_qc_issue:
ata_port=2 ata_dev=0 tag=18 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:90:c0:00:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.910434: ata_qc_issue:
ata_port=2 ata_dev=0 tag=19 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:98:00:01:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.910489: ata_qc_issue:
ata_port=2 ata_dev=0 tag=20 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:a0:40:01:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.910546: ata_qc_issue:
ata_port=2 ata_dev=0 tag=21 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:a8:80:01:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.910599: ata_qc_issue:
ata_port=2 ata_dev=0 tag=22 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:b0:c0:01:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.910659: ata_qc_issue:
ata_port=2 ata_dev=0 tag=23 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:b8:00:02:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.910711: ata_qc_issue:
ata_port=2 ata_dev=0 tag=24 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:c0:40:02:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.910766: ata_qc_issue:
ata_port=2 ata_dev=0 tag=25 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:c8:80:02:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.910818: ata_qc_issue:
ata_port=2 ata_dev=0 tag=26 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:d0:c0:02:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.910879: ata_qc_issue:
ata_port=2 ata_dev=0 tag=27 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:d8:00:03:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.910934: ata_qc_issue:
ata_port=2 ata_dev=0 tag=28 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:e0:40:03:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.910985: ata_qc_issue:
ata_port=2 ata_dev=0 tag=29 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:e8:80:03:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.911041: ata_qc_issue:
ata_port=2 ata_dev=0 tag=30 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:f0:c0:03:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.911097: ata_qc_issue:
ata_port=2 ata_dev=0 tag=0 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:00:00:04:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.911152: ata_qc_issue:
ata_port=2 ata_dev=0 tag=1 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:08:40:04:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.911203: ata_qc_issue:
ata_port=2 ata_dev=0 tag=2 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:10:80:04:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.911263: ata_qc_issue:
ata_port=2 ata_dev=0 tag=3 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:18:c0:04:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.911318: ata_qc_issue:
ata_port=2 ata_dev=0 tag=4 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:20:00:05:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.911371: ata_qc_issue:
ata_port=2 ata_dev=0 tag=5 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:28:40:05:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.911427: ata_qc_issue:
ata_port=2 ata_dev=0 tag=6 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:30:80:05:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.911481: ata_qc_issue:
ata_port=2 ata_dev=0 tag=7 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:38:c0:05:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.911538: ata_qc_issue:
ata_port=2 ata_dev=0 tag=8 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:40:00:06:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.911592: ata_qc_issue:
ata_port=2 ata_dev=0 tag=9 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:48:40:06:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.911649: ata_qc_issue:
ata_port=2 ata_dev=0 tag=10 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:50:80:06:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.911710: ata_qc_issue:
ata_port=2 ata_dev=0 tag=11 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:58:c0:06:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.911765: ata_qc_issue:
ata_port=2 ata_dev=0 tag=12 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:60:00:07:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.911820: ata_qc_issue:
ata_port=2 ata_dev=0 tag=13 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:68:40:07:00/00:00:00:00:00/40)
             fio-4212  [001] d...  2426.911874: ata_qc_issue:
ata_port=2 ata_dev=0 tag=14 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:70:80:07:00/00:00:00:00:00/40)
          <idle>-0     [000] d.h.  2426.912187: ata_qc_complete_done:
ata_port=2 ata_dev=0 tag=16 flags=75048c{ IO RETRY FAILED EH_SCHEDULED
} status={ DRDY }  res=(40/00:00:00:00:00/00:00:00:00:00/00)
          <idle>-0     [000] dNs.  2426.912314: ata_qc_issue:
ata_port=2 ata_dev=0 tag=16 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:80:c0:07:00/00:00:00:00:00/40)
             fio-4212  [000] d.h.  2426.912396: ata_qc_complete_done:
ata_port=2 ata_dev=0 tag=17 flags=7991cc{ IO QUIET RETRY FAILED }
status={ DRDY }  res=(40/00:00:00:00:00/00:00:00:00:00/00)
             fio-4212  [000] d...  2426.912510: ata_qc_issue:
ata_port=2 ata_dev=0 tag=17 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:88:00:08:00/00:00:00:00:00/40)
          <idle>-0     [000] d.h.  2426.912633: ata_qc_complete_done:
ata_port=2 ata_dev=0 tag=18 flags=7b3f2c{ IO CLEAR_EXCL FAILED
SENSE_VALID } status={ DRDY }
res=(40/00:00:00:00:00/00:00:00:00:00/00)
          <idle>-0     [000] dNs.  2426.912666: ata_qc_issue:
ata_port=2 ata_dev=0 tag=18 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:90:40:08:00/00:00:00:00:00/40)
          <idle>-0     [000] d.h.  2426.912879: ata_qc_complete_done:
ata_port=2 ata_dev=0 tag=15 flags=77974c{ IO QUIET FAILED SENSE_VALID
EH_SCHEDULED } status={ DRDY }
res=(40/00:00:00:00:00/00:00:00:00:00/00)
          <idle>-0     [000] dNs.  2426.912939: ata_qc_issue:
ata_port=2 ata_dev=0 tag=15 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:78:80:08:00/00:00:00:00:00/40)
             fio-4212  [000] d.h.  2426.913109: ata_qc_complete_done:
ata_port=2 ata_dev=0 tag=19 flags=7862cc{ IO QUIET RETRY } status={
DRDY }  res=(40/00:00:00:00:00/00:00:00:00:00/00)
             fio-4212  [000] d.s.  2426.913125: ata_qc_issue:
ata_port=2 ata_dev=0 tag=19 proto=ATA_PROT_NCQ cmd=ATA_CMD_FPDMA_READ
tf=(60/40:98:c0:08:00/00:00:00:00:00/40)

(Entirety of the trace file is available from
https://sucs.org/~sits/test/20190109-libata-ftrace.txt )

Just to check - was the above how you are supposed to enable libata tracing?

-- 
Sitsofe | http://sucs.org/~sits/
