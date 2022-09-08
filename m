Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9E2FC38145
	for <linux-block@archiver.kernel.org>; Thu,  8 Sep 2022 07:33:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbiIHHd1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 8 Sep 2022 03:33:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbiIHHd0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 8 Sep 2022 03:33:26 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C285AA3FA
        for <linux-block@vger.kernel.org>; Thu,  8 Sep 2022 00:33:24 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 15A9A1FB42;
        Thu,  8 Sep 2022 07:33:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1662622403; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DjWnutcERGcTDtNJJ1NJNU3+CBp5j41iPAyRCaDt3AU=;
        b=Vq5rdFXbxAbRQ7Hm0/FnunJYJeUv+1R5rzG4GJ/qSBGGxoocNES0VU11vnbobFXASjT6ai
        3FrSAPHiUSnPsslGq5rekT0wCivSjZJJVzfaw53txvfy+oj+pkW65Q2fbDOQSGo13N6cyh
        JS0xqV6lV3//QvL+/lFf/0ZB6877Vqg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1662622403;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DjWnutcERGcTDtNJJ1NJNU3+CBp5j41iPAyRCaDt3AU=;
        b=Sm2zS5HpFOWWqhd5nZCS2KUUybhxOartIldeUnKkOay4C3DYcX1mF9sJhd82QcgnLMPDv1
        3LtrhhXTuSwgsABw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 09DA613A6D;
        Thu,  8 Sep 2022 07:33:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id EMVeAsOaGWM1FQAAMHmgww
        (envelope-from <dwagner@suse.de>); Thu, 08 Sep 2022 07:33:23 +0000
Date:   Thu, 8 Sep 2022 09:33:22 +0200
From:   Daniel Wagner <dwagner@suse.de>
To:     Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Hannes Reinecke <hare@suse.de>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>
Subject: Re: [PATCH blktests v2] nvme/045: test queue count changes on
 reconnect
Message-ID: <20220908073322.oh2cdzwyqwjiyomm@carbon.lan>
References: <20220831153506.28234-1-dwagner@suse.de>
 <20220908000222.elkaqaz4l3a2x66k@shindev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908000222.elkaqaz4l3a2x66k@shindev>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

On Thu, Sep 08, 2022 at 12:02:24AM +0000, Shinichiro Kawasaki wrote:
> Thanks for the patch. First of all, the commit title says nvme/045, but it adds
> nvme/046. Also I made a couple of comments on this patch in line.

Ah it's a stupid copy&past error. Will update it accordingly.

> I ran the added test case and observed test case failure [1] and KASAN
> slab-out-of-bounds [2]. To run this test case, I applied this patch on top of
> the PR #100 [3] and used kernel at nvme-6.1 branch tip 500e781dc0b0 at
> "git://git.infradead.org/nvme.git". Is this failure expected? Or do I miss
> any required set up to pass the test case?

No, the crash you observed is not expected. I'll look into it. I suspect
it has something to do with

  '/sys/class/nvme-fabrics/ctl//state: No such file or directory'

>> > +requires() {
> > +	_nvme_requires
> > +	_have_loop
> > +	_require_nvme_trtype_is_fabrics
> > +	_require_min_cpus 2
> 
> From my curiosity, what's the reason to require 2 cpus?

The number of CPUs define how many queues we will setup or request from
the target. As this tests starts with the default queue counts requested
by the host and then limits the queues count to 1 on the target side we
need to have more than 1 queue requested initially. I think it's
worthwhile to add this as comment to the test.

> > +_set_nvmet_attr_qid_max() {
> > +	local nvmet_subsystem="$1"
> > +	local qid_max="$2"
> > +	local cfs_path="${NVMET_CFS}/subsystems/${nvmet_subsystem}"
> > +
> > +	if [[ -f "${cfs_path}/attr_qid_max" ]]; then
> > +		echo $qid_max > "${cfs_path}/attr_qid_max"
> 
> I ran 'make check' and noticed the line above triggers a shellcheck warning:
> 
>     tests/nvme/rc:553:8: note: Double quote to prevent globbing and
>     word splitting. [SC2086]

Will fix it.

> [1] test case failure messages
> 
> $ sudo ./check nvme/046
> nvme/046 (Test queue count changes on reconnect)             [failed]
>     runtime  88.104s  ...  87.687s
>     --- tests/nvme/046.out      2022-09-08 08:35:02.063595059 +0900
>     +++ /home/shin/kts/kernel-test-suite/src/blktests/results/nodev/nvme/046.out.bad    2022-09-08 08:43:54.524174409 +0900
>     @@ -1,3 +1,86 @@
>      Running nvme/046
>     -NQN:blktests-subsystem-1 disconnected 1 controller(s)
>     +grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
>     +grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
>     +grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
>     +grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
>     +grep: /sys/class/nvme-fabrics/ctl//state: No such file or directory
>     ...
>     (Run 'diff -u tests/nvme/046.out /home/shin/kts/kernel-test-suite/src/blktests/results/nodev/nvme/046.out.bad' to see the entire diff)
> 
> [2] KASAN: slab-out-of-bounds
> 
> [  151.315742] run blktests nvme/046 at 2022-09-08 08:42:26
> [  151.834816] nvmet: adding nsid 1 to subsystem blktests-feature-detect
> [  152.170966] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
> [  152.514592] nvmet: creating nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uuid:.
> [  152.522907] nvme nvme6: Please enable CONFIG_NVME_MULTIPATH for full support of multi-port devices.
> [  152.527164] nvme nvme6: creating 4 I/O queues.
> [  152.533543] nvme nvme6: new ctrl: "blktests-subsystem-1"
> [  154.339129] nvme nvme6: Removing ctrl: NQN "blktests-subsystem-1"
> [  175.599995] ==================================================================
> [  175.601755] BUG: KASAN: slab-out-of-bounds in nvmet_subsys_attr_qid_max_store+0x13d/0x160 [nvmet]
> [  175.603816] Read of size 1 at addr ffff8881138dc450 by task check/946
> 
> [  175.605801] CPU: 1 PID: 946 Comm: check Not tainted 6.0.0-rc2+ #3
> [  175.607232] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.16.0-0-gd239552ce722-prebuilt.qemu.org 04/01/2014
> [  175.609735] Call Trace:
> [  175.610412]  <TASK>
> [  175.611039]  dump_stack_lvl+0x5b/0x77
> [  175.612016]  print_report.cold+0x5e/0x602
> [  175.612999]  ? nvmet_subsys_attr_qid_max_store+0x13d/0x160 [nvmet]

Hmm, as qid_max is more or less a copy of existing attributes it might
not the only attribute store operation which has this problem.

Thanks for the review!
Daniel
