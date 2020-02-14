Return-Path: <SRS0=urI+=4C=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12F37C3B195
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 09:09:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E82B82086A
	for <linux-block@archiver.kernel.org>; Fri, 14 Feb 2020 09:09:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgBNJJy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Feb 2020 04:09:54 -0500
Received: from mout.kundenserver.de ([212.227.126.133]:33387 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726004AbgBNJJx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Feb 2020 04:09:53 -0500
Received: from mail-qk1-f172.google.com ([209.85.222.172]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MvsyF-1jIp9D0379-00sruX; Fri, 14 Feb 2020 10:09:52 +0100
Received: by mail-qk1-f172.google.com with SMTP id w15so8514686qkf.6;
        Fri, 14 Feb 2020 01:09:51 -0800 (PST)
X-Gm-Message-State: APjAAAVpGzCvn3TrqF0sTgxI71i6581hMcWTOCRaSO1omTJAIaSidDKZ
        YARVga/dR5a54HLdpQr+9ucQA2Sq7s4dwm3hQ7w=
X-Google-Smtp-Source: APXvYqxh028ChAc8N1k4FZjK4jhf4HQEXUKLNb21unbBirlpHH7Mcc1k2Nx0SldXFlCm5Z41/Vb6p4zPWXOV8tEVuro=
X-Received: by 2002:a05:620a:909:: with SMTP id v9mr1516008qkv.138.1581671390700;
 Fri, 14 Feb 2020 01:09:50 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
In-Reply-To: <CA+G9fYuqAQfhzF2BzHr7vMHx68bo8-jT+ob_F3eHQ3=oFjgYdg@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 14 Feb 2020 10:09:34 +0100
X-Gmail-Original-Message-ID: <CAK8P3a09YDtmOjpBWQEsKd09aotvUW6tOoxUE=CYxh1g8hNW7A@mail.gmail.com>
Message-ID: <CAK8P3a09YDtmOjpBWQEsKd09aotvUW6tOoxUE=CYxh1g8hNW7A@mail.gmail.com>
Subject: Re: LKFT: arm x15: mmc1: cache flush error -110
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Alexei Starovoitov <ast@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-block <linux-block@vger.kernel.org>,
        lkft-triage@lists.linaro.org,
        open list <linux-kernel@vger.kernel.org>,
        linux-mmc <linux-mmc@vger.kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Mark Brown <broonie@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:u1u2uKcPKdrt69fdOzIH3uPc4q8YGxq5TGOZx2RP5uR2lukOopR
 dLdqjKzGlLzYzDlPYNmrIj51AUWNxLDWs5TvFJHsYl4JRj/Oxqx9CK2EfY40a222myUmrHw
 XYDHvw2EGAFp2ZqGQWxocEwBE24qvn2ht8MZgB7MF1ssVxUAKSYNz+VNuDtKNOGEPNsikBh
 OrhpFZQv5ol08rmdHc2vw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:getncO7sm3I=:gxKt2RWF3LRJTSuoPBZrqA
 tDhA65huQXs8RdA6+PXMWXbI3BC0m/f1DVa6dPdx3e8J/FKASJxK4uqngzvUSsrJHVZ3pNn7+
 jwZWBIXJckwDeE3SNMZzZ8UzVuV/4W286FL7BemNySpeZ1P3SOyMKMvkRQ7gP4GP2Tpb/rhvd
 YITkpVs4OEQg/eWOCiUzl7QAhKjJRVdYlHpOlpIz2IveKcSEuaKuaOgScBtsmygUbrSeLzsiX
 ENJVVn02tI9YY3nnlZz+p5mGUKIH8DcyOg31o3lmS+O+3f8hAHX9XM2kkG99OM058jp0A2wab
 MWzdcc6e/I+C70sLKx/s0267fHxP3yQutU9szm/ntd44ANvun188zOEIgmRLL5ewFFqTVoiEs
 IHR0LPWB5MlP2/+43diSS/s/dVvxhSVsrCUW/cW2uWNWVKPz5NI4wUzVBHmIEtmOnrI0Ac7YS
 IamFCXrl1XtJpICQnDFvku8kowaM4q26BhpOpbsS3JyoHZ/DBEswlu/753ewe02EYDTq9F2cX
 PdhU2ZAJmzm6NGtQOKFGFRA7ScUlkG5IA61NuI3mQ87FH6Q1f1Y1CYmd0o10qLDurjV5iD2Dr
 taSTBREdB9UiT+RMIP68Cmo0ArlEeGWnE+Ku+Unos/laX0JksRYW+VwHMxxG+vBpEgxs74PW0
 bjlGJ8B8gNy1OJ33/e49EMBnMT6KmpLlRhK2si4yUEx+tXstI5Ke8slM7ROx/ygp2eeW3etI5
 8m4pyO21TxyYivtAzQeu5ZDejahz8oaR+ZhSJVIzb7afksTjN16P1OJfZsLcat4t6HYfk41HJ
 epA7DGo36QY9TyrCGjdEMGz59Ecuu7h57B01Ywf0t/S+jEzf7U=
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

On Thu, Feb 13, 2020 at 4:43 PM Naresh Kamboju
<naresh.kamboju@linaro.org> wrote:
>
> arm beagleboard x15 device failed to boot Linux mainline and
> linux-next kernel due
> to below error.
> This error occurred across all x15 device for these kernel version.
>
> This regression started happening on x15 from this commit onwards (27th Jan)
>   git branch: master
>   git repo: https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>   git commit: aae1464f46a2403565f75717438118691d31ccf1
>   git describe: v5.5-489-gaae1464f46a2

Is it only the merge that introduced the issue, or is the branch that got
merged already broken?

If it's easy for you to reproduce, please run the same test on commit
e4e4c2ff78ed from Mark's regulator tree to narrow it down further.

Added Mark to Cc as well, in case it is indeed one of those.

      Arnd

8<---
> Test output log,
> [   37.606241] mmc1: Card stuck being busy! mmc_poll_for_busy
> [   37.611850] mmc1: cache flush error -110
> [   37.615883] blk_update_request: I/O error, dev mmcblk1, sector
> 4302400 op 0x1:(WRITE) flags 0x20800 phys_seg 1 prio class 0
> [   37.627387] Aborting journal on device mmcblk1p9-8.
> [   37.635448] systemd[1]: Installed transient /etc/machine-id file.
> [   37.659283] systemd[1]: Couldn't move remaining userspace
> processes, ignoring: Input/output error
> [   37.744027] EXT4-fs error (device mmcblk1p9):
> ext4_journal_check_start:61: Detected aborted journal
> [   37.753322] EXT4-fs (mmcblk1p9): Remounting filesystem read-only
> [   37.917486] systemd-gpt-auto-generator[108]: Failed to dissect:
> Input/output error
> [   37.927825] systemd[104]:
> /lib/systemd/system-generators/systemd-gpt-auto-generator failed with
> exit status 1.
> <>
> [   68.856307] mmc1: Card stuck being busy! mmc_poll_for_busy
> [   68.861838] mmc1: cache flush error -110
> [   68.865812] blk_update_request: I/O error, dev mmcblk1, sector 0 op
> 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> <>
> [   98.906243] mmc1: Card stuck being busy! mmc_poll_for_busy
> [   98.911774] mmc1: cache flush error -110
> [   98.915747] blk_update_request: I/O error, dev mmcblk1, sector 0 op
> 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> <>
> Dependency failed for Serial Getty on ttyS2.
> [  128.946258] mmc1: Card stuck being busy! mmc_poll_for_busy
> [  128.951786] mmc1: cache flush error -110
> [  128.955756] blk_update_request: I/O error, dev mmcblk1, sector 0 op
> 0x1:(WRITE) flags 0x800 phys_seg 0 prio class 0
> [FAILED] Failed to start File System Check on Root Device.
> See 'systemctl status systemd-fsck-root.service' for details.
> [  OK  ] Started Apply Kernel Variables.
> [  OK  ] Reached target Login Prompts.
>          Starting Remount Root and Kernel File Systems...
> [  OK  ] Reached target Timers.
> [  OK  ] Closed Syslog Socket.
> [  OK  ] Started Emergency Shell.
> [  129.227328] EXT4-fs error (device mmcblk1p9): ext4_remount:5354:
> Abort forced by user
> [  OK  ] Reached target Emergency Mode.
> [  OK  ] Reached target Sockets.
> [FAILED] Failed to start Remount Root and Kernel File Systems.
> <>
> You are in emergency mode. After logging in, type \"journalctl -xb\" to view
> system logs, \"systemctl reboot\" to reboot, \"systemctl default\" or \"exit\"
> to boot into default mode.
> Press Enter for maintenance
> auto-login-action timed out after 874 seconds
>
> ref:
> https://lkft.validation.linaro.org/scheduler/job/1137693#L4034
> https://lkft.validation.linaro.org/scheduler/job/1158106#L4048
> https://lkft.validation.linaro.org/scheduler/job/1137690#L3985
> https://lkft.validation.linaro.org/scheduler/job/1137691#L4012
> https://lkft.validation.linaro.org/scheduler/job/1137696#L4043
> https://lkft.validation.linaro.org/scheduler/job/1137699#L4153
