Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com [209.85.210.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FD73264DD
	for <linux-block@vger.kernel.org>; Sat,  5 Sep 2026 20:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788640416; cv=none; b=spQ//dcH2imVB4WNvxa1eval5QfgRK6JHMOwqMMqjUhOuRwppqj1ZTSNtOB/IWrcEkQGq/wU7N/E3t18X1P0wlcb1buwxHxbtJCRoSRcyabQj21UYqWBKtWh++kKMePRXYMQSk9yMEFaFEIu70/ilD/OAMbRIsxr3xR72N4PPRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788640416; c=relaxed/simple;
	bh=VEyTOk2wnJuWL/0aDXAN5YhjuaqFPCGeVVSL0O/+rwk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Guj8PGP25XoJz0WjLYx3RT60LMeESXFurwrSqckrhE/ECJresO3xQyngQpKYTIEulhrl14rN3svA/NHBKjn94rf1Rw+ExLfPBQSDvMatQFOyIX6B7X+9FRvjg+V0J8n8nO58Lq23ckO1QDVS9mtuLBOYR0HPXXtpou/wN+qm1l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7e6b59d85dcso4371197a34.3
        for <linux-block@vger.kernel.org>; Sat, 05 Sep 2026 13:33:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788640414; x=1789245214;
        h=content-type:to:from:subject:message-id:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DaK/UszpBwoJ72t5z8E9yTVEpqhHUeXVcZVl5D5Td0o=;
        b=bwH0qAjPLazGv7pyVoz+eDGS9ZmxEm4mkTFjt9gzF60tVXT8ftKZAC9IYsD+TfB+Yi
         A95M3m/UVGTYoNuqLtp+JWqnswLbU9wdjappm3wwJOli5dRRD7LZwmEWPaYlfCIR2DBz
         VXra0jYlwaUGmB7ORajN/TjJct+jHIcbG4um1kOeZukOPhzcSNNVU0P06g/jWgJSIa1F
         VjFO75UWq0JVjBwnOZ8FQHmBW+s0pZjGoaCCtl6PcqPeGuPjDRlA77pPlRHyNxFkJieq
         VKQLi6drb15bzz+4xxfE7SMuTeBmL1145yBDozHa7I0eMABggG5HF3xQTxTzc6L113be
         sHYg==
X-Gm-Message-State: AFuF++nx6G8SwR3z8JQoOYeK6Ort86UIPCZYO2s8uFeBSJAMhBiyElJp
	FAQnuoVhbzr03rzSlL7LVlszoadAh1CnAIv93yqZvQMr2b0Zvb84uKX/KaYQATtc8c+0Z2/3LYT
	KZJuvkSLMfqQSy7DZPb5u2PVfxIlxXevtR9ZCYJnTNx9WJpjBBde4/mRtk78=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:82a:b0:6b3:4a99:bd87 with SMTP id
 006d021491bc7-6b6fd7ca02bmr8376303eaf.30.1788640414366; Sat, 05 Sep 2026
 13:33:34 -0700 (PDT)
Date: Sat, 05 Sep 2026 13:33:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9c7c9e.87c06881.102b7.0001.GAE@google.com>
Subject: [syzbot] Monthly block report (Sep 2026)
From: syzbot <syzbot+list6a51048a59f44a26a220@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 10 new issues were detected and 4 were fixed.
In total, 32 issues are still open and 118 have already been fixed.
There are also 30 low-priority issues.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1741    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<2>  87      No    INFO: task hung in read_cache_folio (6)
                   https://syzkaller.appspot.com/bug?extid=9db0864859224b833108
<3>  57      Yes   INFO: task hung in __rq_qos_throttle (2)
                   https://syzkaller.appspot.com/bug?extid=53706c567afab5131044
<4>  29      No    possible deadlock in blkcg_deactivate_policy (2)
                   https://syzkaller.appspot.com/bug?extid=14254d81dd19ba7d7e41
<5>  16      Yes   INFO: task hung in blkdev_read_iter
                   https://syzkaller.appspot.com/bug?extid=afa7aef0c237038586e7
<6>  11      No    BUG: unable to handle kernel paging request in blk_mq_complete_request_remote
                   https://syzkaller.appspot.com/bug?extid=2e3bf0bd49acd9b21d4b
<7>  1249    Yes   WARNING in blk_mq_free_tag_set
                   https://syzkaller.appspot.com/bug?extid=02b37e31e64ea5cb6d29
<8>  94      Yes   INFO: rcu detected stall in kjournald2 (2)
                   https://syzkaller.appspot.com/bug?extid=14c6ac6811273526cfa5
<9>  30      Yes   KASAN: slab-out-of-bounds Read in blk_mq_free_rqs
                   https://syzkaller.appspot.com/bug?extid=e90526cab23b9efcd03c
<10> 13      No    KASAN: slab-out-of-bounds Read in seq_buf_putmem
                   https://syzkaller.appspot.com/bug?extid=f179b16e13624138b0f1

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
