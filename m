Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4711E0DDF
	for <linux-block@vger.kernel.org>; Mon, 20 Jan 2025 13:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737378386; cv=none; b=B9rkuSTx6gG69lVGSaNOGiVeHtB4yXYxn+B2NgqwHRvRNcm1aEWma+HKbvXJTemR4FIFEGVGLH5AyPQtTla2/84gb+r8AQobUQM1f2SHY6RHmxNEPOLTpMqkalW90EoxQ5F80HC3TYz1kr6ok/kmkC65XjEqMe0hMcM34jKtYXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737378386; c=relaxed/simple;
	bh=eylIaYrCeBd7TLXqFTpQAEcjvFtqUFLHN/uXIUU1+fQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=M0ED62o0+zaoWiQdbysmBPSznLDQJwMUbnPPiP4ISFkKChrt85GZl5VuEcMrPT7QmI4TPTK493d8ElL3XmSPqSAxhhWbmqQbU2ed3ipz8YBMfuV1IyMJrd4KUkflVBL8gukU0NRI3mh8/3jMVBu+UgJoCoSl3KxnPw3WRMDDl6A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3cf6ceaccdbso31555125ab.1
        for <linux-block@vger.kernel.org>; Mon, 20 Jan 2025 05:06:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737378384; x=1737983184;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ngBXUoN0qgly+v92vCKvkPOzlgH1yvouV0caRkqUsGw=;
        b=OCV6zJUZB18mNSR6oIw8y9r7+6N2qxiGSJsezQAvAPI254vQ91fRnymEqmohpHVSXO
         2vUZYOS+Bu7rvUtzZxekdpMtO+4PSrijeusgDtzIdLWPAgIowuIOsssg8/Go7UMmh7Ri
         VBFFVy/t1OShm/9lc+TrOVPiLlOjybUx4m+xq+TJ2C1ZcdUGOz3eN38QnHMCwP40d1kw
         nVwT4fNiB+jtB1V/JzJnRAp//1r1b5By3qPS6zenfu11iipRXAFvacVCxa7SQmgEXgnX
         kilf17UnWP9YgAeIbw+c/NP5ukyzYQ4rcANgptcd2Ui/oIxU/Sko8R2K/iDKii9RHPkL
         mEiQ==
X-Gm-Message-State: AOJu0YzYqq4v3s18ujl9eG0gJDkTeF7HwQ+zkBkO7gcV+koojRf7cQrr
	iG0iqodB2QH/oqzOAn8X4JqQvP7CnvhidpG5/g6pdTr+7XJA7sog+/J3r1rYkK1Y8BHoEVqg/YK
	xkDUtNn2lGxeUxwZCJ8Vf43NXbYKOYeMAt2dqzRLGjoMQ6PdG8GjeVjk=
X-Google-Smtp-Source: AGHT+IH5ku0WyA3TxFpVGYns42Rz+kgFSxFGEIGq86SdTigAd6FZUumdcLL/0lcVJJxQeeV8d3nPPNJ081mE77mLXXB7Uy7Fi2/p
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16ce:b0:3ce:8d4e:9c79 with SMTP id
 e9e14a558f8ab-3cf743d2bcamr103391435ab.4.1737378383917; Mon, 20 Jan 2025
 05:06:23 -0800 (PST)
Date: Mon, 20 Jan 2025 05:06:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678e4a4f.050a0220.303755.0077.GAE@google.com>
Subject: [syzbot] Monthly block report (Jan 2025)
From: syzbot <syzbot+listfc97652af697e61c3368@syzkaller.appspotmail.com>
To: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello block maintainers/developers,

This is a 31-day syzbot report for the block subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/block

During the period, 5 new issues were detected and 0 were fixed.
In total, 46 issues are still open and 94 have already been fixed.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  59531   Yes   possible deadlock in __submit_bio
                   https://syzkaller.appspot.com/bug?extid=949ae54e95a2fab4cbb4
<2>  4822    Yes   KMSAN: kernel-infoleak in filemap_read
                   https://syzkaller.appspot.com/bug?extid=905d785c4923bea2c1db
<3>  2964    Yes   possible deadlock in blk_trace_setup
                   https://syzkaller.appspot.com/bug?extid=0d8542c90a512dc95185
<4>  2822    Yes   possible deadlock in loop_reconfigure_limits
                   https://syzkaller.appspot.com/bug?extid=867b0179d31db9955876
<5>  2461    Yes   INFO: task hung in bdev_release
                   https://syzkaller.appspot.com/bug?extid=4da851837827326a7cd4
<6>  1865    Yes   KASAN: slab-use-after-free Read in percpu_ref_put (2)
                   https://syzkaller.appspot.com/bug?extid=905d719acdbd213bf67e
<7>  1662    Yes   INFO: task hung in blkdev_fallocate
                   https://syzkaller.appspot.com/bug?extid=39b75c02b8be0a061bfc
<8>  594     No    INFO: task hung in bdev_open
                   https://syzkaller.appspot.com/bug?extid=5c6179f2c4f1e111df11
<9>  345     No    possible deadlock in loop_set_status
                   https://syzkaller.appspot.com/bug?extid=9b145229d11aa73e4571
<10> 40      Yes   possible deadlock in blk_mq_submit_bio
                   https://syzkaller.appspot.com/bug?extid=5218c85078236fc46227

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.
