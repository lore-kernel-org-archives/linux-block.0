Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED,URIBL_SBL,URIBL_SBL_A autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0132EC282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 10:48:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CF3E420857
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 10:48:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbfA3KsM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 05:48:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58304 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726548AbfA3KsM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 05:48:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 9266B882EA;
        Wed, 30 Jan 2019 10:48:11 +0000 (UTC)
Received: from [10.43.2.41] (unknown [10.43.2.41])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B62FD176C2;
        Wed, 30 Jan 2019 10:48:10 +0000 (UTC)
From:   =?UTF-8?Q?Ond=c5=99ej_Lyson=c4=9bk?= <olysonek@redhat.com>
Subject: Spurious device addition uevents sometimes get sent after removing a
 loop device
Openpgp: preference=signencrypt
Autocrypt: addr=olysonek@redhat.com; prefer-encrypt=mutual; keydata=
 mQENBFg+zDMBCAC+5X7D1MlGuCwhGp6thNiLqOTIk625Q8CAtD/hG9r4XvMwbwOHjnKCRO43
 JNOVz81c+x5g7RlaCx4t7CjiNZAsCGXOOY95Zo0BmWlhfNYyo/y140TM9lZcoCa+7Alwnaq3
 Jzfc++GGXVsi1gI+eiC99ldLEMMUm/wbI52SktvfeKoeqqVbNv95XoPY4Ff2vmn87d7R82I7
 NoK4vCzKrMxMaI32EHO3tyUQePGz/snd1oWvh4ZKSryhUfWctuyB/4pv0qtwds3SU6zvgIq/
 ePwUG2tiHA5Ue+sPHEADNJ/MiA7q0CiftJeFbX/EeP8luq1thW6Spx31inYKp8ZHoe1TABEB
 AAG0Jk9uZMWZZWogTHlzb27Em2sgPG9seXNvbmVrQHJlZGhhdC5jb20+iQFUBBMBCAA+AhsD
 BQsJCAcCBhUICQoLAgQWAgMBAh4BAheAFiEE0MQtJh1N/CzvMuY4uTa3RyWJM1gFAlu+Ba4F
 CQVgbPsACgkQuTa3RyWJM1i8oAf/QSSP+xreJuZPO0AcMO3XjL61i4qFz5Zf6hVMEsr9VOBe
 NGqssUeSm+26eeXNxodiU8+AsrhYq7XByvjMFMFvsObnS4tbeBp/uFL/z10BkKyMy2wtEsow
 gbjd3awfOMJhxvl/X9ISMNDaws17XVBbMMKiMzFc2Qsan6MuSYt5iyNbNT1kHDh1hUwOBkTc
 RuSBCwpMNGcFQOPOacfguCxlrNrdlgwY7YnGK6p4PUxA7aGu7lU2VI5nfCxUxBXJUAt8z82e
 YEPvu74xm9rSzGCREbSls9TS2rAeGuxd+FcykutO5yHU9IF+95HwH/DJAuYhhC5Hv2O+Heg7
 yhVR30BDy7kBDQRYPswzAQgA3oSAStaoJzoq7uM+eBzSGE9rWgnTy8M8d8N9JeZuH3vHVATJ
 lnSnrbNW4Izd3BfD0dd0ROKYHexCo5d+7rSW3SFHzCwPMCPq5IuSrYuz7zc12hARr0lfUvYE
 jccl5KR7Uv5OjXnf3FZQ/jF0dxHSqYQeKCE1A4Nyr6b9SSM/LRuUVUR+F3NSgv8kMF7QlF87
 Eqk+DQO8fhgHaiQz/66AdZqr4NVxqN0hsQtvrwWRm2gBXG0KBYrEGhffuiiBfGJ8A91uyPFs
 Y+LcXUYTdh1kqUuJ3VjJli7vcVWNR201lt89S/dKlAD8oTst5D2+qLtD9HqhKr/3NdKwuO08
 jq6LWwARAQABiQE8BBgBCAAmAhsMFiEE0MQtJh1N/CzvMuY4uTa3RyWJM1gFAlvkVWwFCQVg
 gTkACgkQuTa3RyWJM1gqxwf/f5DR1Wk87hqmBxuK+h0oQTljlHQBU61ubGb0OFDc782CufCN
 UtoPvjt6lA1Eeih9A5ruB3YcM86I9TPpj93QNJe4++XA8FYm9LhuxBSGTLiWsicjzgUsJ9Qf
 emRyXmq2bWf7RxyhQ7H1x/7N8+/GSeBarlPlwSfCX0SwitrMqrjLRJ2vuPVYqxBzc2lXHUpL
 S865iSrLgGiXH+fGmJIc0YDNMQgCpI3enhoZM2FLQ06ncXWocVNT4VqrIuUMdOi9RkhTpe3W
 Z7cRv+XcibBt4p/oD/NSzs+PYE9J2wIAMHHdi4bmHSoajG4LfT/qOM38ishhR9I/v9uuoCbs
 rocZkw==
To:     axboe@kernel.dk, linux-block@vger.kernel.org
Message-ID: <56e4bd63-1c85-7d68-3d38-1ca794e61247@redhat.com>
Date:   Wed, 30 Jan 2019 11:48:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.4.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Wed, 30 Jan 2019 10:48:11 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

I'd like to report a problem I ran into, where the kernel sends device
removal uevents immediately followed by spurious device addition
uevents. This happens after removing a loop device using the
LOOP_CTL_REMOVE ioctl on /dev/loop-control.

I can reproduce it with the following program on a vanilla 5.0-rc4
kernel, as well as Fedora's kernel-4.20.4-200.fc29.x86_64.

#include <err.h>
#include <stdio.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <sys/ioctl.h>
#include <linux/loop.h>
#include <unistd.h>
#include <errno.h>

int main(void)
{
	const int devnum = 0;
	int ctl_fd;
	int removed = 0;

	ctl_fd = open("/dev/loop-control", O_RDWR);
	if (ctl_fd == -1)
		err(1, "ctl open");
	if (ioctl(ctl_fd, LOOP_CTL_ADD, devnum) == -1)
		err(1, "add ioctl");

	while (!removed) {
		if (ioctl(ctl_fd, LOOP_CTL_REMOVE, devnum) == -1) {
			/* Sometimes we get EBUSY here.
			 * Is that expected? */
			if (errno != EBUSY) {
				err(1, "ioctl");
			}
		} else {
			removed = 1;
		}
	}
	if (close(ctl_fd) == -1) {
		err(1, "close");
	}

	return 0;
}

If I run it like this:
$ while sudo ./reproducer && ! test -e /dev/loop0; do true; done

then after about a minute the loop terminates without any errors and
/dev/loop0 exists.

Monitoring the uevents sent by the kernel (udevadm monitor --kernel)
reveals that during most of the executions of the program, the following
uevents get sent:
KERNEL[99.624241] add      /devices/virtual/bdi/7:0 (bdi)
KERNEL[99.624392] add      /devices/virtual/block/loop0 (block)
KERNEL[99.624779] remove   /devices/virtual/bdi/7:0 (bdi)
KERNEL[99.624845] remove   /devices/virtual/block/loop0 (block)

However, sometimes the removal uevents are followed by spurious device
addition uevents:
KERNEL[153.723097] add      /devices/virtual/bdi/7:0 (bdi)
KERNEL[153.723172] add      /devices/virtual/block/loop0 (block)
KERNEL[153.723406] remove   /devices/virtual/bdi/7:0 (bdi)
KERNEL[153.724265] remove   /devices/virtual/block/loop0 (block)
KERNEL[153.746690] add      /devices/virtual/bdi/7:0 (bdi)
KERNEL[153.746931] add      /devices/virtual/block/loop0 (block)

This results in /dev/loop0 being readded by udev.

I can reproduce the problem more easily if I actually bind an image file
to the loop device, e.g. like this (the referenced file.img is just
filled with zeros):
https://paste.fedoraproject.org/paste/o6jqJV8pBiTEk8lXIMcX-g

Have you seen this?

Thanks!

Best regards
Ondřej Lysoněk

