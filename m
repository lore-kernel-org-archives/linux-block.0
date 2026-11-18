Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=195.135.223.130
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794994005;
	b=5VXto5w/WE2CWtkW/fFLjVEJ3PkkeEk7dT6tqVZDMQN69GDng4BruFjxsP9QG9HwTHTp
	 5dIpiUDZTYQlY/WTZoBurIopGM97P1BdE/yLys2rfPRv4L8PT9yGlOrGJifr269KBmaCB
	 led+eA9P/eTmMRe+BSK6wSsh5BglkSUNYeGfUS935iE4BPiMz+DOOQCj2zcsyj7BkLGx8
	 hW6oMzedFXdfXqGi2zN5ht3IZDFO40GeJz91QZRO+XSrhNKfRU0bvSgJz5OMjrNbqAzoN
	 PIBj2Wz+v3Ebxw3ec1IkV4KYUIWjQuCZy6ezuHjgAWkkNnHMtiYNaERXmoeg+lFasbg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794994005;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:DKIM-Signature:
	 DKIM-Signature:Received:Received:From:Subject:Date:Message-Id:
	 MIME-Version:Content-Type:Content-Transfer-Encoding:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer:X-Spam-Flag:X-Spam-Level:X-Spamd-Result:
	 X-Spam-Score;
	bh=oeyfLCxsP9w5ROWq/+IA3erdwWt3rQ3/CJxahg2mGAI=;
	b=ZysY7ZNY/x+6VoQQ4x9/PiNYz+rK77DoBdkg8X09/3Jp7qGzmeIZV7Yb9/6MLY3aeij/
	 Q3b8LWO2giBxHirWJySWLKxANdg1MoLZNm1q9dr82Sa+HSjfmuxBNOVbd+BrJNP4U+rFE
	 3ucPlGHsMUzXj2DsqRJthxI5AY8czci7gBRtmt3VtRT/ukW3vBJdgsSjv8moP4QmJiaD2
	 mV7oSqy5Y7HE67BW1liUP+Nr1VRo39bmghfF83FLr5iJfEQ+wJ0B0jSExpNhzUHxo+C7Q
	 qEW6y+MrbOMr8cgkmniHsMH7VG/JvtBAjNbHl90G0puHnyJhXXhxFhMjuPyIQLlp9NQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=suse.de;
	spf=pass smtp.mailfrom=suse.de;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GFhnPvoP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d0w5dp0P;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GFhnPvoP;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d0w5dp0P;
	arc=none smtp.remote-ip=195.135.223.130
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25B4A606A31C
	for <linux-block@vger.kernel.org>; Wed, 18 Nov 2026 09:26:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25B4A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GFhnPvoP;
	dkim=pass header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d0w5dp0P;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.a=rsa-sha256 header.s=susede2_rsa header.b=GFhnPvoP;
	dkim=neutral header.d=suse.de header.i=@suse.de header.a=ed25519-sha256 header.s=susede2_ed25519 header.b=d0w5dp0P
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 1438E22229;
	Wed, 18 Nov 2026 09:26:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794994002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oeyfLCxsP9w5ROWq/+IA3erdwWt3rQ3/CJxahg2mGAI=;
	b=GFhnPvoPhnsMIBT6Dxzd9s/hqtyrutd4OBEgLZgfKmh3+S/44jVpKT7Iywg0Z9Bw0OaMXj
	7A4W8ARPkGb5Ho9PPvPbNHxU9cpIuErQ/91FIZvxvgjhRvmT07ocB29hjymhC/2WJXFY39
	WTU1BhK4LVeoINXTA3l3iChNynJe2Wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794994002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oeyfLCxsP9w5ROWq/+IA3erdwWt3rQ3/CJxahg2mGAI=;
	b=d0w5dp0P5dFMBjQowd3e+OJVGPKsUsQ1OU9tK0ylCxn0QrjbEgE4Y9k+CLmDbGvOworG4t
	mMP1rmdjXE/YqiAg==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1794994002; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oeyfLCxsP9w5ROWq/+IA3erdwWt3rQ3/CJxahg2mGAI=;
	b=GFhnPvoPhnsMIBT6Dxzd9s/hqtyrutd4OBEgLZgfKmh3+S/44jVpKT7Iywg0Z9Bw0OaMXj
	7A4W8ARPkGb5Ho9PPvPbNHxU9cpIuErQ/91FIZvxvgjhRvmT07ocB29hjymhC/2WJXFY39
	WTU1BhK4LVeoINXTA3l3iChNynJe2Wk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1794994002;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oeyfLCxsP9w5ROWq/+IA3erdwWt3rQ3/CJxahg2mGAI=;
	b=d0w5dp0P5dFMBjQowd3e+OJVGPKsUsQ1OU9tK0ylCxn0QrjbEgE4Y9k+CLmDbGvOworG4t
	mMP1rmdjXE/YqiAg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id BEB501334C;
	Wed, 18 Nov 2026 09:26:41 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id lIVbJVFv/Wq3fQAAD6G6ig
	(envelope-from <dwagner@suse.de>); Wed, 18 Nov 2026 09:26:41 +0000
From: Daniel Wagner <dwagner@suse.de>
Subject: [PATCH blktests v2 0/9] nvme: make NVME_TARGET_CONTROL work with
 remote targets
Date: Wed, 18 Nov 2026 10:26:38 +0100
Message-Id: <20261118-nvme-target-control-v2-0-d191bbbf5dd6@suse.de>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32Py26DMBBFfwV5XVd+1RhW+Y8qC8YMxE0w1GNQq
 yj/XkOqLrsczcw5994ZYQpIrK3uLOEWKMyxDOqlYv7SxRF56MvMlFBWSmF43CbkuUsjZu7nmNN
 844MApRu0DlTDyueScAhfB/Wdwe2akTKx83NDK3ygzzt0v70EynP6PgJs8vj417VJLjhoCUa86
 RrAnGglfO2RnR9PQcLPtfTIv/6/GqXVAZY1p2tY+BSIQhx5jwtxLQrQGds4b9qSo6CgIyzaaQq
 5rerGazXs3hp8ZzujnYbaNEILqZx12g8WLJiS4vEDTS3Ni1UBAAA=
X-Change-ID: 20261104-nvme-target-control-f0b239e68b29
To: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>
X-Mailer: b4 0.16.0
X-Spam-Flag: NO
X-Spam-Level: 
X-Spamd-Result: default: False [-13.30 / 50.00];
	SUSE_INTERNAL_BYPASS(-9.00)[];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ARC_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Score: -13.30

Hi all,

this series makes running the nvme tests against a remote target with
NVME_TARGET_CONTROL actually work. The first six patches of v1 have been
applied, this is the rest. It applies on top of the series that makes
tests skip when a program they need is missing.

The first two patches are fixes: nvme/047 looks up the namespace again
after reconnecting, and the nvmet target picks free service IDs for its
ports. The third is a cleanup, nvme/042 and nvme/043 iterate over the
DH-HMAC-CHAP hashes by name.

The remaining patches let tests skip instead of failing when the remote
target lacks a feature they need, including the DH-HMAC-CHAP hashes and
DH groups the target doesn't support, add port and host key support for
remote targets, and add a NetApp ONTAP target as an example of a target
that can do less than nvmet.

Tested against nvmet in a second VM, which also exported other
subsystems on its own ports, and against a NetApp ONTAP array. All tests
that can run against a remote target pass, except nvme/077 against
nvmet, which checks attr_qid_max in the local nvmet configfs. Against
the array, nvme/061 and nvme/070 fail because it refuses the reconnect
after a subsystem is deleted and doesn't support Identify CNS 07h, and
nvme/068 because the host runs a 6.4 kernel. The tests that need the
kernel target still pass with the local target.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
Changes in v2:
- Drop the six patches that were applied.
- Fix nvme/047 to look up the namespace again after reconnecting.
- Pick free service IDs for new nvmet ports.
- Pass the TLS option in the argument array instead of an unquoted
  command substitution; quoting it would pass an empty argument without
  TLS. (Shin'ichiro)
- Check the features with =~, with an SC2076 exception for the literal
  match. (Shin'ichiro)
- List the DH-HMAC-CHAP algorithms a target supports, iterate over them
  by name in nvme/042 and nvme/043 and skip the ones the target lacks.
- Put the fixes first, then the cleanup, then the features.
- Depend on the series that makes tests skip when a program is missing.
- Link to v1: https://patch.msgid.link/20261104-nvme-target-control-v1-0-b31b40537bb4@suse.de

---
Daniel Wagner (9):
      nvme/047: look up the namespace again after reconnecting
      contrib/nvme-target-control: pick a free service ID for new nvmet ports
      nvme/042, nvme/043: iterate over the DH-HMAC-CHAP hashes by name
      nvme: skip tests that need a feature the remote target lacks
      contrib/nvme-target-control: list the DH-HMAC-CHAP algorithms
      nvme: skip the DH-HMAC-CHAP algorithms the target doesn't support
      common/nvme: support the ports of a remote target
      nvme/rc: change the host keys on a remote target
      contrib/nvme-target-control: add a NetApp ONTAP target

 Documentation/running-tests.md                     |  49 ++-
 common/nvme                                        |  88 ++++-
 contrib/nvme-target-control/README.md              |  72 +++-
 .../nvme_target_control/target.py                  |  19 +
 .../nvme_target_control/targets/nvmet.py           |  12 +-
 .../nvme_target_control/targets/nvmet.sh           |   7 +-
 .../nvme_target_control/targets/ontap.py           | 397 +++++++++++++++++++++
 contrib/nvme-target-control/tests/test_ontap.py    | 357 ++++++++++++++++++
 .../tests/test_target_control.py                   |   4 +-
 tests/nvme/031                                     |   1 +
 tests/nvme/041                                     |   1 +
 tests/nvme/042                                     |  12 +-
 tests/nvme/042.out                                 |   8 +-
 tests/nvme/043                                     |   9 +-
 tests/nvme/043.out                                 |   6 +-
 tests/nvme/044                                     |   1 +
 tests/nvme/045                                     |   1 +
 tests/nvme/047                                     |   2 +
 tests/nvme/057                                     |   1 +
 tests/nvme/062                                     |   1 +
 tests/nvme/063                                     |   5 +-
 tests/nvme/rc                                      |  58 +++
 22 files changed, 1069 insertions(+), 42 deletions(-)
---
base-commit: 79c32fb31b7bca6a4383b749030128683cf6b6b4
change-id: 20261104-nvme-target-control-f0b239e68b29
prerequisite-change-id: 20261117-skip-missing-deps-30b4084698c4:v1
prerequisite-patch-id: 9478a4106d922c8432a4d297dcb18ed68a9c8d61
prerequisite-patch-id: 635fcb82ae72c78b84ad593a58d82315a166724d
prerequisite-patch-id: 528ad89bda84f0b0d9cbc0d38b6e1384332f86cd
prerequisite-patch-id: 2758a16b44a326eea5113ff4967e6093ad42e71c
prerequisite-patch-id: 9acbf0ff52b0b46035e4635035662cd9d9309f77

Best regards,
--  
Daniel Wagner <dwagner@suse.de>

