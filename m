Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D334078F5
	for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 23:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790724258; cv=none; b=FY73hxHWqd0UyiKjvVTqY3EoxIly/XnJ2+I0r3y8HVu5c67LNgGuFFXnfz94KnrxFbmm5MEB9vnJoCSkyEqTkzMHH7x0oGtaDwh0TTXAoBMoWZ0PZa8E0HrywqtG3Slq+quTP0eEHaccxrOueNuBXm8Xb0OSaEc+7Cju+CT7hPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790724258; c=relaxed/simple;
	bh=l+ODbziUsCsodJP0tJtfa6YvEYqHs3zu/ydWE/aLqaM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qXLe7K+6/ZpetC8huEOUkZ8GEPZt7ErOp5cyPX/DMujw2B9DhmS8aIu8mBbcbAdPbblp2CqvUb59zRW9wAOtiaAhvG8vuXh6Mq13y7aUwpchMWKCyQeWpr70lorFJK1JybWWR0RtbD1WWUQ9srqbwqrB2fBO5Wa2JrWSUmwoYlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qRZ3p9eS; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qRZ3p9eS"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d8fbef5018so32345275ad.0
        for <linux-block@vger.kernel.org>; Tue, 29 Sep 2026 16:24:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790724256; x=1791329056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IS6TByWFgsxOTPGaMQkR8btgGIqLwW1a4rgcn4lxTW4=;
        b=qRZ3p9eSe+bkKOXVduSJEEVKhmkz6mwtKLf/bt+n+c/2XUc+NczhxV5lrLMConx3l+
         oqM4vTm4LhdXyUSMLQNMSbfyo8rC5TlMSIOZ2/yOyKXBZsueNfF/6TdRK1CKGlHLf9to
         N71JKw3Fquo+eBwjHJ4Py6Un5T6yyje6xNMLllpVMtV8Noz8FzWvSrEYv0u4L+Bg6g1n
         qJWub5Q2FwzYOJ7FyugV3e+Ef/2Rtz95gu90TAI8vQxUvhdr7D044OpzGDnQVYJrNUBt
         IgoOyHcOTENzfheigP8rUWV7XF47F+9dGeb9kFMnAbo5nDQJi7dUkw1VABPZyDtMxsU0
         2dQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790724256; x=1791329056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IS6TByWFgsxOTPGaMQkR8btgGIqLwW1a4rgcn4lxTW4=;
        b=U1OsEHiauSB+2ThmFkDxOfjBoAQkdWw+CFCFn9B5L886gsBWBLiwoNn/pql7XuldPm
         /Kq9oMg6lzdATB23Dn8p1Po8QWRAAjichM+oCl8KVueeH4iRG702ne5uxpWGYwco7dnS
         9pBRgJlI5gDRFAqJ3NF9UC6RpeAzAX1BZm9Rgnqz+LcVewOmIvMCXaYT5NkyLC673HHV
         HVnSj8UhIUnoXrGeKdcBLlMbRL1b5QT4x4fUE3jN6UiUraRlhBT1byCjaigUdjAosTBA
         g3PjU7lG87Jasn3nB2gKQBuwGxvUJPjh2SUME0gBQf0iAOHgNdzO2GUawoTSz2ixDtWd
         OtGQ==
X-Forwarded-Encrypted: i=1; AKwUvByPN9SKQs0qG5QxasW3rO0wdOBpd+3+lAOb6g5vcgaRFXRFzGDegjUBnJwGjbetEE3uh/HU0RSMx97F2w==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ/YdTBjOSNex4nR9httE53OuUxzGfFytO/ouaXvIHo0pMDC9+s
	PXlSNLvQDrwzk1yP7VPiheMOqxBvXDT9XtM4ercb3+2LPSvgsSR/0+Mo
X-Gm-Gg: AYBFou2RlXfVparyNR+IPQQYvrUaqx4RNaB2ZY4N/dgaJDP2DhGtB+5TwYv9QX5RE6f
	iM0llx2qtZl2mFUWeArpVP/CoMaGURHHi/IwzYdJZJdUIAMYZFiNdTWHuve6cVBRDvUuXc6SkCx
	cYjpTGT7LGqihU8FLEAG+XoVbQE0RlxwaLw/Kfy+40fyInTFjR/P5uxpUtYgTtuxoTd2F70/FTC
	AlzVZ9XYXTSF0rgAuBuYL0Od0yydLKQidLU5m7+asDD/zx3hvgNHNTxyrFHyRLBDllXKmaQQVlv
	DohGaJ9lFNuwLsNRNAnQ3udu65juP2JHKrIljBXO170UpvQEn37p/8F4fnZW4s8VfSpy9UCmSHE
	+nLSCQqHdc+ZQc1KpVXT2zgx+IYF/M9EKJ33vIApUjkC4AzbVxoxcvJxlU62VCIK01XibVgMDc7
	XmyDaJJMLx2SDiok/DNlkdbsUOyQPfjG6k2FfoSxOUVnjagF+bsNSJsLUdN2lGUbhzZyQRtctK8
	MRllJEcY2sImFAcYatlDY3x5OQUxZSIVoWyE6DQJdVUHPbTFGFHV5QtGnt4zh+ZnvOr54cxrVGR
	dLI=
X-Received: by 2002:a17:90b:4f89:b0:3a0:4444:ef1e with SMTP id 98e67ed59e1d1-3a4bfe73db9mr752355a91.29.1790724256010;
        Tue, 29 Sep 2026 16:24:16 -0700 (PDT)
Received: from yupeng-XPS-15-9520.. (c-73-169-192-12.hsd1.wa.comcast.net. [73.169.192.12])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a4ca78102csm138700a91.4.2026.09.29.16.24.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 16:24:15 -0700 (PDT)
From: Peng Yu <yupeng0921@gmail.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	=?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jens Axboe <axboe@kernel.dk>,
	Maurizio Lombardi <mlombard@arkamax.eu>,
	cgroups@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Peng Yu <yupeng0921@gmail.com>
Subject: [PATCH v7 0/2] nvmet: add cgroup_id to charge namespace I/O to a cgroup
Date: Tue, 29 Sep 2026 16:24:09 -0700
Message-ID: <20260929232411.101087-1-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change since v6:
* 1/2: Explain in the commit message why the effective css is tracked,
  and add comments on e_css[] and in init_cgroup_root() (Tejun).
* 2/2: Use cgroup_get_e_css() and css_put() in nvmet_blkcg_set_bio()
  instead of cgroup_e_css() under rcu_read_lock() (Tejun).
* Drop "cgroup: export cgroup_e_css()", which is no longer needed (Tejun).

Change since v5:
* Add "cgroup: track the effective css in each cgroup", so looking up
  the effective css for each I/O is O(1) (Tejun).

Change since v4:
* Hold the cgroup and look up its effective io css for each I/O,
  instead of pinning one io css when the namespace is enabled (Tejun).
* Allow a cgroup that doesn't have the io controller enabled (Tejun).
* Add "cgroup: export cgroup_e_css()".

The two patches don't depend on each other: 2/2 only uses symbols that
are already exported and works without 1/2, with the slower lookup.
1/2 can go through the cgroup tree and 2/2 through the nvme tree.

v6: https://lore.kernel.org/all/20260928061417.1574676-1-yupeng0921@gmail.com/
v5: https://lore.kernel.org/all/20260926063328.257023-1-yupeng0921@gmail.com/
v4: https://lore.kernel.org/all/20260924053121.17703-1-yupeng0921@gmail.com/
v3: https://lore.kernel.org/all/20260923152653.40953-1-yupeng0921@gmail.com/
v2: https://lore.kernel.org/all/20260922065115.22508-1-yupeng0921@gmail.com/
v1: https://lore.kernel.org/all/20260908011214.11344-1-yupeng0921@gmail.com/

Scenario:
* Create multiple nvmet subsystems/namespaces.
* The namespaces are backed by different LVM logical volumes.
* Some of the logical volumes share the same physical volumes.
* The subsystems are exported to different users.
* We should provide each user a specific iops/bps quota, thus a noisy
  neighbor won't impact the performance of other logical volumes.

Test:
1 Load kernel modules.
sudo modprobe brd rd_nr=2 rd_size=1048576
sudo modprobe nvmet
sudo modprobe nvmet_tcp
sudo modprobe nvme_tcp

2 The two brd devices are used for a bdev backed namespace and a file
backed namespace, remember their major/minor.
lsblk --noheadings --nodeps --output NAME,MAJ:MIN,SIZE /dev/ram0 /dev/ram1
ram0   1:0      1G
ram1   1:1      1G

3 Enable the io controller and create two cgroups, one for the bdev
backed namespace, another for the file backed namespace.
echo "+io" | sudo tee /sys/fs/cgroup/cgroup.subtree_control
sudo mkdir -p /sys/fs/cgroup/nvmet-bdev
sudo mkdir -p /sys/fs/cgroup/nvmet-file

4 Create a file system and a file on ram0.
sudo mkfs.ext4 /dev/ram0
sudo mkdir -p /mnt/nvmet-file
sudo mount -o noatime /dev/ram0 /mnt/nvmet-file
sudo dd if=/dev/zero of=/mnt/nvmet-file/ns.img bs=1M count=512 oflag=direct

5 Create the bdev backed subsystem and namespace.
sudo mkdir -p /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev/namespaces/1
echo 1 | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev/attr_allow_any_host
echo /dev/ram1 | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev/namespaces/1/device_path
stat -c %i /sys/fs/cgroup/nvmet-bdev | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev/namespaces/1/cgroup_id
echo 1 | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev/namespaces/1/enable

6 Create the file backed subsystem and namespace.
sudo mkdir -p /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file/namespaces/1
echo 1 | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file/attr_allow_any_host
echo /mnt/nvmet-file/ns.img | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file/namespaces/1/device_path
stat -c %i /sys/fs/cgroup/nvmet-file | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file/namespaces/1/cgroup_id
echo 1 | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file/namespaces/1/enable

7 Export the two subsystems to 127.0.0.1.
sudo mkdir -p /sys/kernel/config/nvmet/ports/1
echo ipv4 | sudo tee /sys/kernel/config/nvmet/ports/1/addr_adrfam
echo tcp | sudo tee /sys/kernel/config/nvmet/ports/1/addr_trtype
echo 127.0.0.1 | sudo tee /sys/kernel/config/nvmet/ports/1/addr_traddr
echo 4420 | sudo tee /sys/kernel/config/nvmet/ports/1/addr_trsvcid
sudo ln -s /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev /sys/kernel/config/nvmet/ports/1/subsystems/nqn.2026-09.io.test01:bdev
sudo ln -s /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file /sys/kernel/config/nvmet/ports/1/subsystems/nqn.2026-09.io.test01:file

8 Connect the two subsystems from 127.0.0.1.
sudo nvme connect -t tcp -a 127.0.0.1 -s 4420 -n nqn.2026-09.io.test01:bdev
sudo nvme connect -t tcp -a 127.0.0.1 -s 4420 -n nqn.2026-09.io.test01:file
sudo udevadm settle

9 Set riops to 20k and run fio.
echo "1:1 riops=20000 wiops=max rbps=max wbps=max" | sudo tee /sys/fs/cgroup/nvmet-bdev/io.max
echo "1:0 riops=20000 wiops=max rbps=max wbps=max" | sudo tee /sys/fs/cgroup/nvmet-file/io.max

sudo fio --name=t --filename=/dev/nvme0n1 --rw=randread --bs=4k --iodepth=32 --numjobs=1 \
--direct=1 --ioengine=libaio --time_based --runtime=10 --ramp_time=3 \
--group_reporting 2>/dev/null | grep -E '^ +(read|write): IOPS'
  read: IOPS=20.0k, BW=78.1MiB/s (81.9MB/s)(781MiB/10001msec)

sudo fio --name=t --filename=/dev/nvme1n1 --rw=randread --bs=4k --iodepth=32 --numjobs=1 \
--direct=1 --ioengine=libaio --time_based --runtime=10 --ramp_time=3 \
--group_reporting 2>/dev/null | grep -E '^ +(read|write): IOPS'
  read: IOPS=20.0k, BW=78.2MiB/s (82.0MB/s)(782MiB/10001msec)

10 Set rbps to 100M and run fio.
echo "1:1 riops=max wiops=max rbps=104857600 wbps=max" | sudo tee /sys/fs/cgroup/nvmet-bdev/io.max
echo "1:0 riops=max wiops=max rbps=104857600 wbps=max" | sudo tee /sys/fs/cgroup/nvmet-file/io.max

sudo fio --name=t --filename=/dev/nvme0n1 --rw=read --bs=1M --iodepth=32 --numjobs=1 \
--direct=1 --ioengine=libaio --time_based --runtime=10 --ramp_time=3 \
--group_reporting 2>/dev/null | grep -E '^ +(read|write): IOPS'
  read: IOPS=97, BW=100MiB/s (105MB/s)(1041MiB/10399msec)

sudo fio --name=t --filename=/dev/nvme1n1 --rw=read --bs=1M --iodepth=32 --numjobs=1 \
--direct=1 --ioengine=libaio --time_based --runtime=10 --ramp_time=3 \
--group_reporting 2>/dev/null | grep -E '^ +(read|write): IOPS'
  read: IOPS=97, BW=100MiB/s (105MB/s)(1031MiB/10299msec)

11 Set wiops to 20k and run fio.
echo "1:1 riops=max wiops=20000 rbps=max wbps=max" | sudo tee /sys/fs/cgroup/nvmet-bdev/io.max
echo "1:0 riops=max wiops=20000 rbps=max wbps=max" | sudo tee /sys/fs/cgroup/nvmet-file/io.max

sudo fio --name=t --filename=/dev/nvme0n1 --rw=randwrite --bs=4k --iodepth=32 --numjobs=1 \
--direct=1 --ioengine=libaio --time_based --runtime=10 --ramp_time=3 \
--group_reporting 2>/dev/null | grep -E '^ +(read|write): IOPS'
  write: IOPS=20.0k, BW=78.1MiB/s (81.9MB/s)(781MiB/10001msec); 0 zone resets

sudo fio --name=t --filename=/dev/nvme1n1 --rw=randwrite --bs=4k --iodepth=32 --numjobs=1 \
--direct=1 --ioengine=libaio --time_based --runtime=10 --ramp_time=3 \
--group_reporting 2>/dev/null | grep -E '^ +(read|write): IOPS'
  write: IOPS=20.0k, BW=78.1MiB/s (81.9MB/s)(781MiB/10002msec); 0 zone resets

12 Set wbps to 100M and run fio.
echo "1:1 riops=max wiops=max rbps=max wbps=104857600" | sudo tee /sys/fs/cgroup/nvmet-bdev/io.max
echo "1:0 riops=max wiops=max rbps=max wbps=104857600" | sudo tee /sys/fs/cgroup/nvmet-file/io.max

sudo fio --name=t --filename=/dev/nvme0n1 --rw=write --bs=1M --iodepth=32 --numjobs=1 \
--direct=1 --ioengine=libaio --time_based --runtime=10 --ramp_time=3 \
--group_reporting 2>/dev/null | grep -E '^ +(read|write): IOPS'
  write: IOPS=97, BW=100MiB/s (105MB/s)(1032MiB/10307msec); 0 zone resets

sudo fio --name=t --filename=/dev/nvme1n1 --rw=write --bs=1M --iodepth=32 --numjobs=1 \
--direct=1 --ioengine=libaio --time_based --runtime=10 --ramp_time=3 \
--group_reporting 2>/dev/null | grep -E '^ +(read|write): IOPS'
  write: IOPS=97, BW=100MiB/s (105MB/s)(1033MiB/10296msec); 0 zone resets

13 Cleanup the environment.
sudo nvme disconnect -n nqn.2026-09.io.test01:bdev
sudo nvme disconnect -n nqn.2026-09.io.test01:file
sudo udevadm settle

sudo rm -f /sys/kernel/config/nvmet/ports/1/subsystems/nqn.2026-09.io.test01:bdev
sudo rm -f /sys/kernel/config/nvmet/ports/1/subsystems/nqn.2026-09.io.test01:file
sudo rmdir /sys/kernel/config/nvmet/ports/1

echo 0 | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev/namespaces/1/enable
sudo rmdir /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev/namespaces/1
sudo rmdir /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:bdev

echo 0 | sudo tee /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file/namespaces/1/enable
sudo rmdir /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file/namespaces/1
sudo rmdir /sys/kernel/config/nvmet/subsystems/nqn.2026-09.io.test01:file

sudo umount /mnt/nvmet-file
sudo rmdir /mnt/nvmet-file
sudo modprobe -r brd

sudo rmdir /sys/fs/cgroup/nvmet-bdev
sudo rmdir /sys/fs/cgroup/nvmet-file

sudo rmmod nvme_tcp
sudo rmmod nvmet_tcp
sudo rmmod nvmet

Peng Yu (2):
  cgroup: track the effective css in each cgroup
  nvmet: add cgroup_id to charge namespace I/O to a cgroup

 drivers/nvme/target/configfs.c    | 47 ++++++++++++++++++++++++
 drivers/nvme/target/core.c        | 54 ++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c | 18 +++++++++-
 drivers/nvme/target/io-cmd-file.c | 21 +++++++++--
 drivers/nvme/target/nvmet.h       | 58 ++++++++++++++++++++++++++++++
 drivers/nvme/target/zns.c         |  5 +++
 include/linux/cgroup-defs.h       |  8 +++++
 kernel/cgroup/cgroup.c            | 60 ++++++++++++++++++++-----------
 8 files changed, 247 insertions(+), 24 deletions(-)


base-commit: 2ee54f01f07c0307deaf90ca8691a4643ae0357b
-- 
2.53.0

