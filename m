Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2091350FD
	for <linux-block@vger.kernel.org>; Thu, 27 Jun 2024 09:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719479434; cv=none; b=Mtm1gAF/eRvtqdT8May68qWDTE4gb/xgE2vHXm+FjUXWnhRzy22KEFILrokEePNLvrZilywP62A2UgVItorH+szRSAuayFbRN3A91GfDdhsHANNmI2EHqiopGnoi2R7wqm/MpJ5Iouw9nJQqrThWFgDre4C/o0F5qCj4g37VgFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719479434; c=relaxed/simple;
	bh=nr9ojk5LONvcpIDIKt/G1zPW/6O8nzCdpDNCbVEC8n0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LfgkaV5RuSl0Pw35K8lJ16c9CFTOq+PvgrmpF5fXW7Hndv64zmcrKrTN06U9ZOz0rkSSut0/B0OCy56hJ4dTwFTz5foFEfRg/IEDzTeLvWLFq0bJAjH4CWQ4nUPLnvj6MdzN7EptBY+x0KSXDd2nuetXpb6MTrDpboDAQZwKFVQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=Af9EZ+qP; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=bnHqfboV; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=xp0NI0f/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=2uZSBmqn; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="Af9EZ+qP";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="bnHqfboV";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="xp0NI0f/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="2uZSBmqn"
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 133731FBB1;
	Thu, 27 Jun 2024 09:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719479424; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zbby7y/4D2GAaGFRYuMjkPb03xd9SNWETTVFoF3fiFY=;
	b=Af9EZ+qPOmTyIQq2LJ42C6aRhh/8maJcq3a/74Qrh8D4HUWtCPsUV4j417GbPq6kCFfva3
	gfTsd0p+t0u/EPxhDt6YTc6HBBcbWQ2BFW+vTcE8nqROV08zxoTMaHjWeA6muHUtzYoeKk
	ToU2AJ/2soK3KVRTxa7Aop3aGsSCfnE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719479424;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zbby7y/4D2GAaGFRYuMjkPb03xd9SNWETTVFoF3fiFY=;
	b=bnHqfboVPzmlFu+8fbQTXw8nzmbUFkckubJA4EyFbDkk/SDgZaavezGGzg5NEAlLuzD5sU
	afLoiAZRumO8qUBg==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1719479423; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zbby7y/4D2GAaGFRYuMjkPb03xd9SNWETTVFoF3fiFY=;
	b=xp0NI0f/E2XD8bgipG7pQ5gFyeekD0UEJojqMj3UziBsm2MfLTq86+sHWyubn7X2b/A3lp
	6odLsnd/QVoGyfwU0vpZ44VmqwBbNblQAdbJlXQasyTNiu1bz8jg6mw8enz+Xx8OXEx2fo
	CzNkicBBjeRZRoXqi5Tdonyagw4ctDo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1719479423;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=zbby7y/4D2GAaGFRYuMjkPb03xd9SNWETTVFoF3fiFY=;
	b=2uZSBmqne57ZP16wWnoY3ckjJd42JGiNGH+I+pIVSZb6E/3NUwz7+TWjb00acNT2t9CDwu
	m28GvPZK3L9tifCA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 04E051384C;
	Thu, 27 Jun 2024 09:10:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id n3E4AH8sfWa1FgAAD6G6ig
	(envelope-from <dwagner@suse.de>); Thu, 27 Jun 2024 09:10:23 +0000
From: Daniel Wagner <dwagner@suse.de>
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: Chaitanya Kulkarni <chaitanyak@nvidia.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v3 0/3] Add support to run against real target
Date: Thu, 27 Jun 2024 11:10:13 +0200
Message-ID: <20240627091016.12752-1-dwagner@suse.de>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Score: -2.80
X-Spam-Level: 
X-Spam-Flag: NO
X-Spamd-Result: default: False [-2.80 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[nvmet:url,imap1.dmz-prg2.suse.org:helo];
	RCVD_TLS_ALL(0.00)[]

I've added a new hook so that the default variables can be configured via t=
he
script. This simple overwrite of the defaults allows to use external config=
ured
setups (there is some trickery involved as it's not possible to do it only =
once
due to include orders). The upside of this approach is that we don't have t=
o add
more environment variables.

I've run blktests against a PowerStore. That worked fairly okay but there w=
ere
some fallouts which is kind of expected at this stage:

# cat ~/.config/blktests/nvme_target_control.toml
[main]
skip_setup_cleanup=3Dtrue
nvmetcli=3D'/home/wagi/work/nvmetcli/nvmetcli'
remote=3D'http://nvmet:5000'

[host]
blkdev_type=3D'device'
trtype=3D'tcp'
hostnqn=3D'nqn.2014-08.org.nvmexpress:uuid:1a9e23dd-466e-45ca-9f43-a29aaf47=
cb21'
hostid=3D'1a9e23dd-466e-45ca-9f43-a29aaf47cb21'
host_traddr=3D'10.161.16.48'

[subsys_0]
traddr=3D'10.162.198.45'
trsvid=3D'4420'
subsysnqn=3D'nqn.1988-11.com.dell:powerstore:00:f03028e73ef7D032D81E'
subsys_uuid=3D'3a5c104c-ee41-38a1-8ccf-0968003d54e7'


# NVME_TARGET_CONTROL=3D/root/blktests/contrib/nvme_target_control.py ./che=
ck nvme

nvme/002 (tr=3Dtcp) (create many subsystems and test discovery) [not run]
    nvme_trtype=3Dtcp is not supported in this test
nvme/003 (tr=3Dtcp) (test if we're sending keep-alives to a discovery contr=
oller)
nvme/003 (tr=3Dtcp) (test if we're sending keep-alives to a discovery contr=
oller) [passed]
    runtime    ...  15.397s
nvme/004 (tr=3Dtcp) (test nvme and nvmet UUID NS descriptors)  [failed]
    runtime    ...  42.584s
    --- tests/nvme/004.out      2024-06-27 09:45:35.496518067 +0200
    +++ /root/blktests/results/nodev_tr_tcp/nvme/004.out.bad    2024-06-27 =
10:38:59.424409636 +0200
    @@ -1,3 +1,4 @@
     Running nvme/004
    -disconnected 1 controller(s)
    +No namespaces found
    +disconnected 13 controller(s)
     Test complete
nvme/005 (tr=3Dtcp) (reset local loopback target)              [passed]
    runtime    ...  11.160s
nvme/006 (tr=3Dtcp bd=3Ddevice) (create an NVMeOF target)        [passed]
    runtime    ...  1.350s
nvme/008 (tr=3Dtcp bd=3Ddevice) (create an NVMeOF host)          [failed]
    runtime    ...  8.748s
    --- tests/nvme/008.out      2024-06-27 09:45:35.496518067 +0200
    +++ /root/blktests/results/nodev_tr_tcp_bd_device/nvme/008.out.bad  202=
4-06-27 10:39:23.624408817 +0200
    @@ -1,3 +1,4 @@
     Running nvme/008
    +UUID 3a5c104c-ee41-38a1-8ccf-0968003d54e7 mismatch (wwid eui.3a5c104ce=
e4138a18ccf0968003d54e7)
     disconnected 1 controller(s)
     Test complete
nvme/010 (tr=3Dtcp bd=3Ddevice) (run data verification fio job)  [passed]
    runtime    ...  29.798s
nnvme/012 (tr=3Dtcp bd=3Ddevice) (run mkfs and data verification fio) [fail=
ed]
    runtime    ...  162.299s
    --- tests/nvme/012.out      2024-06-27 09:45:35.500518066 +0200
    +++ /root/blktests/results/nodev_tr_tcp_bd_device/nvme/012.out.bad  202=
4-06-27 10:42:38.008402238 +0200
    @@ -1,3 +1,6 @@
     Running nvme/012
    +fio: io_u error on file /mnt/blktests//verify.0.0: No space left on de=
vice: write offset=3D44917682176, buflen=3D4096
    +fio exited with status 1
    +4;fio-3.23;verify;0;28;0;0;0;0;0;0;0.000000;0.000000;0;0;0.000000;0.00=
0000;1.000000%=3D0;5.000000%=3D0;10.000000%=3D0;20.000000%=3D0;30.000000%=
=3D0;40.000000%=3D0;50.000000%=3D0;60.000000%=3D0;70.000000%=3D0;80.000000%=
=3D0;90.000000%=3D0;95.000000%=3D0;99.000000%=3D0;99.500000%=3D0;99.900000%=
=3D0;99.950000%=3D0;99.990000%=3D0;0%=3D0;0%=3D0;0%=3D0;0;0;0.000000;0.0000=
00;0;0;0.000000%;0.000000;0.000000;3508332;24662;6165;142251;5;19501;35.466=
984;172.426891;127;60177;2556.665370;1420.047447;1.000000%=3D1056;5.000000%=
=3D1548;10.000000%=3D1646;20.000000%=3D1777;30.000000%=3D1908;40.000000%=3D=
2072;50.000000%=3D2277;60.000000%=3D2441;70.000000%=3D2637;80.000000%=3D293=
2;90.000000%=3D3653;95.000000%=3D4554;99.000000%=3D8224;99.500000%=3D10027;=
99.900000%=3D14745;99.950000%=3D17956;99.990000%=3D39583;0%=3D0;0%=3D0;0%=
=3D0;418;60193;2592.427453;1433.177059;18632;44736;100.000000%;24704.690141=
;4469.952445;0;0;0;0;0;0;0.000000;0.000000;0;0;0.000000;0.000000;1.000000%=
=3D0;5.000000%=3D0;10.000000%=3D0;20.000000%=3D0;30.000000%=3D0;40.000000%=
=3D0;50.000000%=3D0;60.000000%=3D0;70.000000%=3D0;80.000000%=3D0;90.000000%=
=3D0;95.000000%=3D0;99.000000%=3D0;99.500000%=3D0;99.900000%=3D0;99.950000%=
=3D0;99.990000%=3D0;0%=3D0;0%=3D0;0%=3D0;0;0;0.000000;0.000000;0;0;0.000000=
%;0.000000;0.000000;5.627417%;9.681547%;711749;0;22200;0.1%;0.1%;0.1%;0.1%;=
100.0%;0.0%;0.0%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%;0.01%;0.12%;0.29%;0.43=
%;35.65%;56.04%;6.95%;0.47%;0.03%;0.01%;0.00%;0.00%;0.00%;0.00%;0.00%;0.00%=
;nvme0n1;0;1739486;0;0;0;4596624;4596624;100.00%
     disconnected 1 controller(s)
     Test complete
nvme/014 (tr=3Dtcp bd=3Ddevice) (flush a command from host)
^C^C^C

The flush test hanged forever but this could just be an outdated host kerne=
l.

changes:
v3:
  - added support for previous configured target
  - renamed nvme_nvme_target to	_require_kernel_nvme_target
  - use shorter redirect operator
  - https://lore.kernel.org/all/20240612110444.4507-1-dwagner@suse.de/
v2:
  - many of the preperation patches have been merged, drop them
  - added a python script which implements the blktests API
  - add some documentation how to use it
  - changed the casing of the environment variables to upper case

v1:
  - initial version
  - https://lore.kernel.org/linux-nvme/20240318093856.22307-1-dwagner@suse.=
de/

Daniel Wagner (3):
  nvme/rc: introduce remote target support
  nvme/030: only run against kernel soft target
  contrib: add remote target setup/cleanup script

 Documentation/running-tests.md |  33 ++++++
 check                          |   4 +
 contrib/nvme_target_control.py | 181 +++++++++++++++++++++++++++++++++
 contrib/nvmet-subsys.jinja2    |  71 +++++++++++++
 tests/nvme/030                 |   1 +
 tests/nvme/rc                  |  65 +++++++++++-
 6 files changed, 353 insertions(+), 2 deletions(-)
 create mode 100755 contrib/nvme_target_control.py
 create mode 100644 contrib/nvmet-subsys.jinja2

--=20
2.45.2

