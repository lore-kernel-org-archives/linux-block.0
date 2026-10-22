Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792695563;
	b=KPD2UNW3bBFk8LpocfMWP1maILkZtV/DH72hAqdhbBy+1Z/wq7fp5L39M+Olr5iieeFr
	 a0GXiYYUlOW/wuIN3xB7vv7hhD+svIDe9rbQ1scNwnJghds5A1NBTD5cw0eygLbu0ElO7
	 WtmZxLwhoGS9YUiqPbGBFOZ1vQFqCauCEqJOGnw/+zkhbUyIA22oGBecYzqBXKGPnoL/6
	 uYFTwGsX8KsuhdHxav+ZtRgaC4FqBeFZIuhaKWMne2G3IDB4+0Cc8yKAFQ2pp6NKugYlR
	 RkyiKfG9WpD4pUgRpXOMkjqC1sQxsAaJ2u7KXJuyVkal/UgJ3YAB5PfMwCzK7/9evTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792695563;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=Uoh1MRtqWn261E5g0d9SNmqJcwCBiZ4xmaBSkHYprtQ=;
	b=ApwWD23gCN/UykD/so8JYOkODFEC+R0hWlJLc6WGm55xafn85HSkGTVYTLzPCHwdqHkn
	 hiDBoVlvJ6WrDkLj6IXSq2L0hEfM3sGv4hq3ryFxnQWLGoP14L8Q0QoEnLkZrMRXmkhcN
	 UiJd2WQlCTPg2IBz5LrBtug+YKD25tBTg/9VHnUfjde9Y3/04jFEr3vfhU9ne3ujEpAGA
	 o+7Qt5hZ8/wXWP8UWVYYfcbmC9R70qu71q4cXp0RxLy+OandfNDZBuH+szvvTy3ZFlkSH
	 ZMWV+KfNoaeH1ROmLoi+QuA5bXYMQm/NO1WzgRnOu98I729JYFzDBe4dHWpwJW9pBpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Pvqa3XS5;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B850606A31A
	for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 18:59:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2B850606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=Pvqa3XS5
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-1931ff67a29so191542c88.1
        for <linux-block@vger.kernel.org>; Thu, 22 Oct 2026 11:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792695562; x=1793300362; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Uoh1MRtqWn261E5g0d9SNmqJcwCBiZ4xmaBSkHYprtQ=;
        b=Pvqa3XS5oUYYy2//VCUP+J0+QQEN9iBNp35VPhsQ3GSSZfN2Tpqww3J8wCngslPIn+
         yBLBC24/aONrBcMLHSmDlpTk8HfrgQRhWV8a4Q8AGAgDh/5mFP/A7oJ+56Q3BcTNtRL/
         A2HkkVkebQxhraMWXNqQzaKznLzYrBXJV9DO9WBx1xicf2J/WurV6uvfBFqJVxeBNswk
         6spJgNBMDgUNKcdMtGIkrXtmXZ5ZbFqh83YavzQLFejjXzTiPiskvVfFXzsFfnwO/R5Z
         s7Z0ZMsyHkjF4anajWjhDauW9pdbCy6dyCici+ZY4DJI35eS5IwHqpFI61cEPF12/6Gz
         BCMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792695562; x=1793300362;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Uoh1MRtqWn261E5g0d9SNmqJcwCBiZ4xmaBSkHYprtQ=;
        b=lhS8XNsZ5gOBRBkkNomhG2X914u5to1SKas+AO2nB6AAJlZbu1setOlSyD4a3rYx3G
         VEWLHZIakbAeKqcSuzCYlAGhtitpi8fEj9qFmakopaa0c9OvBJEFY7AVtp+ujMKS6xq9
         3OSfzot7/3fxu6ssa888BywvE2uhtL2KBT5sI6tvsWPosVgXTNdvKS4LcjAHD2mrKg/Q
         u4gfp2A51QeM1u8uZSZs09nQyM3GX5+yTEPCfJEdJQGomAUq6FixXY8b9an65VYsFUzO
         DfgzdMZPC1x5pWZ8cRmJi+glj8ZGEJEFHf8/Am3qPl8+/IgGxEUIFGmKodIqgHbYVqGk
         1qOA==
X-Gm-Message-State: AFq9FYIfTg10bBtUgMnRjfTojKpZdEifFN4X9kzYkk4Bv1voB0lkRBY/
	zthrRC9nnYMJIDzbME3O+BvsSqaC1RhN8PRaXoMwU4EMKPmrOhX4OEVLGctDmFsldDY=
X-Gm-Gg: AYBFou1kGXYFlwY4HxyAOumInsMIi2Ao30ePnQ+bmwXPFx/i+jw9k8HxTuABBijvGAR
	LpQlmDc+QTCW630+IznuL3EJQzt0BsjRKZHsZQQpYX3wsCX+nM1SJf11i0nRnlNCwjPzZlpH2RE
	Y6nLLwUTeWvbygXLQkknh+AYQOvpEX30cxf36kOU5FDp6KFla4pwSN/OP4Dls9PLDak97/NMlg2
	wLYKAXzGfILdOole/ngRdEZh1gUBMy45M6lkNnzLZTwbZJf4PpqebrIP6gzB95VwTBQT9nxrCZr
	9giZkIhr7/Nb4D1Dtz17Uf6TieA/P/lf2KTFYb07riJ94Oww0XuNuPaELFd+cXhDr1rtDPN9DJG
	ZX2spQExmph5ZDzxcza/uaOobfzvf+k4Al0wj6+uWQ1K99Tx3yYSqUcW0G3lYx413DN6YAPQ2+J
	hzLvF2A9zoy0OTbSimNpzzwQL7oZYrO6bGMXP/fPYK8dfAyahSDaGoNoHvCK6WCXQrA2rUA7b/r
	FFziaUUiwrcn02Z7P5YUnIJIzRFetHWtX+Bafqbo6V2EhYB6gs11/l8aHF2xl51dZHGfaBSMlNG
X-Received: by 2002:a05:7022:ebc4:b0:15c:705f:b981 with SMTP id a92af1059eb24-195a0379277mr521389c88.32.1792695561683;
        Thu, 22 Oct 2026 11:59:21 -0700 (PDT)
Received: from medusa.lab.kspace.sh ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-195aa59d9c4sm532597c88.22.2026.10.22.11.59.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 11:59:21 -0700 (PDT)
Date: Thu, 22 Oct 2026 11:59:20 -0700
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
	John Meneghini <jmeneghi@redhat.com>,
	Jesse Taube <jtaubepe@redhat.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>
Subject: Re: [PATCH blktests 0/5] nvme: detect ABA ghost writes on multipath
 fabrics
Message-ID: <20261022185920.GA2931-mkhalfella@purestorage.com>
References: <20260917020752.1672578-1-mkhalfella@purestorage.com>
 <arOFG9-sM_GrrbQf@shinmob>
 <20260923170238.GH2931-mkhalfella@purestorage.com>
 <ar8eGV4jsEchjk-R@shinmob>
 <20261020180245.GP2931-mkhalfella@purestorage.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020180245.GP2931-mkhalfella@purestorage.com>

On Tue 2026-10-20 11:02:47 -0700, Mohamed Khalfella wrote:
> On Fri 2026-10-02 05:03:20 +0200, Shin'ichiro Kawasaki wrote:
> > On Sep 23, 2026 / 10:02, Mohamed Khalfella wrote:
> > > On Wed 2026-09-23 17:18:21 +0900, Shin'ichiro Kawasaki wrote:
> > > > On Sep 16, 2026 / 20:06, Mohamed Khalfella wrote:
> > > > 
> > > > Mohamad, thanks for the series. Before I look in the details of the patches,
> > > > I would like make a comment below.
> > > > 
> > > > > Reproducing the race needs an IO that can be held at the target for
> > > > > longer than the host's io_timeout without being failed. The first three
> > > > > patches give miniublk that ability, since there was previously no way to
> > > > > talk to a running ublk server at all:
> > > > > 
> > > > >   1/5  adds a loopback UDP control channel to the daemon, served by a
> > > > >        detached thread, one reply datagram per request
> > > > >   2/5  adds an INJECT_DELAY command which delays a given number of reads
> > > > >        or writes as an io_uring timeout on the queue's own ring
> > > > >   3/5  exposes it as "miniublk inject", which returns only once the
> > > > >        daemon has armed the delay, so a test can start IO immediately
> > > > >        without racing it
> > > > 
> > > > It is interesting to implement the delay feature to miniublk, and use it as the
> > > > testing tool. But I'm not sure if this is the best approach because of two
> > > > points. First, scsi_debug has jdelay and ndelay options. I wonder if this
> > > > existing feature can fulfill the requirements of the new test case. Second, when
> > > > rublk [*] is available in the PATH of the test system, blktests detect it and
> > > > use it instead of miniublk. I guess the added delay feature is not available in
> > > > rublk, and the test case won't work well. What do you think of these points?
> > > > 
> > > 
> > > The two points make sense to me. Let me look at scsi_debug delay
> > > injection mechanism first and see if it can be used here. I will also
> > > look at rublk. Thanks for the pointers.
> > 
> > I've learned that now delay injection is being added to the block layer [*].
> > This looks more generic and could be the best way for this use case.
> > 
> > [*] https://lore.kernel.org/linux-block/20260928221634.43239-1-haris.iqbal@linux.dev/
> 
> Thank you for pointing me to this patchset. The change as in v3 in the
> link above is not sufficient for this case. Block layer "error_inject"
> does not support an option to set the maximum number of times a rule
> should be executed. I want only the first write to be delayed for the
> test to be deterministic.
> 
> That is said, it should not be difficult to close this gap. I will give
> it a shot.

Adding a limit to error injection rule worked.

[ 1244.485435] run blktests nvme/070 at 2026-10-22 11:40:52.361981983
[ 1245.355103] nvmet_tcp: enabling port 0 (127.0.0.1:4420)
[ 1245.401761] nvmet_tcp: enabling port 1 (127.0.0.1:4421)
[ 1245.443655] nvmet: adding nsid 1 to subsystem blktests-subsystem-1
[ 1245.579679] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uui.
[ 1245.587802] nvme nvme4: creating 8 I/O queues.
[ 1245.599665] nvme nvme4: mapped 8/0/0 default/read/poll queues.
[ 1245.612520] nvme nvme4: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4420, hostnqn: nqn.2014-08.org.nvmexpres9
[ 1245.993765] nvmet: Created nvm controller 2 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uui.
[ 1246.001615] nvme nvme5: creating 8 I/O queues.
[ 1246.016800] nvme nvme5: mapped 8/0/0 default/read/poll queues.
[ 1246.031323] nvme nvme5: new ctrl: NQN "blktests-subsystem-1", addr 127.0.0.1:4421, hostnqn: nqn.2014-08.org.nvmexpres9
[ 1246.561862] ublkb0: delaying WRITE at sector 0:8 by 4000000us
[ 1249.908509] nvme nvme4: I/O tag 81 (0051) type 4 opcode 0x1 (Write) QID 7 timeout
[ 1249.910523] nvme nvme4: starting controller fencing
[ 1249.911588] nvme nvme4: attempting CCR, timeout 15000ms
[ 1249.913245] nvmet: ctrl 1 fatal error occurred!
[ 1250.631188] nvme nvme4: CCR succeeded using nvme5
[ 1250.647822] nvme nvme4: Reconnecting in 10 seconds...
[ 1260.710957] nvmet: Created nvm controller 1 for subsystem blktests-subsystem-1 for NQN nqn.2014-08.org.nvmexpress:uui.
[ 1260.718851] nvme nvme4: creating 8 I/O queues.
[ 1260.793810] nvme nvme4: mapped 8/0/0 default/read/poll queues.
[ 1260.805832] nvme nvme4: Successfully reconnected (attempt 1/60)
[ 1330.829938] nvme nvme5: Removing ctrl: NQN "blktests-subsystem-1"
[ 1331.316251] nvme nvme4: Removing ctrl: NQN "blktests-subsystem-1"

This full kernel logs for the test run with block layer delay injection.
A delay of 4 second injected -> io_timeout -> CCR.

diff --git a/tests/nvme/070 b/tests/nvme/070
index e9a4690..85604e7 100755
--- a/tests/nvme/070
+++ b/tests/nvme/070
@@ -51,7 +51,7 @@ set_io_timeout_of_subsystem() {
 test() {
        echo "Running ${TEST_NAME}"

-       local ns port nr_paths
+       local ns port nr_paths einj
        local -a ports

        if ! _init_ublk; then
@@ -84,9 +84,8 @@ test() {

        set_io_timeout_of_subsystem "${def_subsysnqn}" 2000

-       if ! ${UBLK_PROG} inject -n 0 -o write -d 4 -c 1 >> "$FULL" 2>&1; then
-               echo "FAIL: can not inject write delay"
-       fi
+       einj="/sys/kernel/debug/block/ublkb0/error_injection"
+       echo 'add,op=WRITE,status=OK,chance=1,delay_us=4000000,limit=1' > "${einj}"

        ns=$(_find_nvme_ns "${def_subsys_uuid}")
        "$SRCDIR/nvme-ghost-write-detector" "/dev/${ns}"

Changes to the test to use block layer error injection.

diff --git a/block/error-injection.c b/block/error-injection.c
index a35fe41a43e4..4d0150958cff 100644
--- a/block/error-injection.c
+++ b/block/error-injection.c
@@ -29,6 +29,9 @@ struct blk_error_inject {
 
 	/* hold the bio for this long before submitting or failing it */
 	unsigned int			delay_us;
+
+	/* maximum number of times to execute the rule, -1 no limit */
+	atomic_t			limit;
 };
 
 /*
@@ -143,6 +146,8 @@ bool __blk_error_inject(struct bio *bio)
 		if (inj->chance > 1 && (get_random_u32() % inj->chance) != 0)
 			continue;
 
+		if (atomic_dec_if_positive(&inj->limit) == -1)
+			continue;
 		status = inj->status;
 		delay_us = inj->delay_us;
 		break;
@@ -165,7 +170,7 @@ bool __blk_error_inject(struct bio *bio)
 
 static int error_inject_add(struct gendisk *disk, enum req_op op,
 		sector_t start, u64 nr_sectors, blk_status_t status,
-		unsigned int chance, unsigned int delay_us)
+		unsigned int chance, unsigned int delay_us, int limit)
 {
 	struct blk_error_inject *inj;
 	int error = -EINVAL;
@@ -194,6 +199,7 @@ static int error_inject_add(struct gendisk *disk, enum req_op op,
 	inj->status = status;
 	inj->chance = chance;
 	inj->delay_us = delay_us;
+	atomic_set(&inj->limit, limit);
 
 	pr_debug_ratelimited("%pg: adding %s injection for %s at sector %llu:%llu\n",
 			disk->part0, blk_status_to_str(status),
@@ -248,6 +254,7 @@ enum options {
 	Opt_status		= (1u << 19),
 	Opt_chance		= (1u << 20),
 	Opt_delay_us		= (1u << 21),
+	Opt_limit		= (1u << 22),
 
 	Opt_invalid,
 };
@@ -261,6 +268,7 @@ static const match_table_t opt_tokens = {
 	{ Opt_status,			"status=%s"		},
 	{ Opt_chance,			"chance=%u"		},
 	{ Opt_delay_us,			"delay_us=%u"		},
+	{ Opt_limit,			"limit=%d"		},
 	{ Opt_invalid,			NULL,			},
 };
 
@@ -302,6 +310,7 @@ static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
 	u64 start = 0, nr_sectors = 0;
 	blk_status_t status = BLK_STS_OK;
 	substring_t args[MAX_OPT_ARGS];
+	int limit = -1;
 	char *p;
 
 	while ((p = strsep(&options, ",\n")) != NULL) {
@@ -343,6 +352,9 @@ static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
 		case Opt_delay_us:
 			error = match_uint(args, &delay_us);
 			break;
+		case Opt_limit:
+			error = match_int(args, &limit);
+			break;
 		default:
 			pr_warn("unknown parameter or missing value '%s'\n", p);
 			error = -EINVAL;
@@ -354,7 +366,7 @@ static ssize_t blk_error_injection_parse_options(struct gendisk *disk,
 	switch (action) {
 	case Add:
 		return error_inject_add(disk, op, start, nr_sectors, status,
-				chance, delay_us);
+				chance, delay_us, limit);
 	case Removeall:
 		if (option_mask & ~Opt_removeall)
 			return -EINVAL;
@@ -390,11 +402,11 @@ static int blk_error_injection_show(struct seq_file *s, void *private)
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(inj, &disk->error_injection_list, entry) {
-		seq_printf(s, "%llu:%llu op=%s,status=%s,chance=%u,delay_us=%u",
+		seq_printf(s, "%llu:%llu op=%s,status=%s,chance=%u,delay_us=%u,limit=%d",
 			   inj->start, inj->end,
 			   blk_op_str(inj->op),
 			   blk_status_to_tag(inj->status), inj->chance,
-			   inj->delay_us);
+			   inj->delay_us, atomic_read(&inj->limit));
 		seq_putc(s, '\n');
 	}
 	rcu_read_unlock();

And here is the change to block error injection to add a limit to error
injection rules. It missing documentation change but that should be
trivial to add.

Now, I need to follow with the patchset adding delay injection to see if
that can get merged.
