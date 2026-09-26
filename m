Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7925E38DC68
	for <linux-block@vger.kernel.org>; Sat, 26 Sep 2026 06:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790404414; cv=none; b=jHjr8qrYq3X/VJueZW1k57fMv44kggzzYmT7LGlRp03jCugajY9lm5ulUxUOTmSkimSV2JQy7POexFYjHWHdbzxcbn67RDMIACsgJG3J3glPX46XDibbYdcd4Pz/WKQ164ADy11w0EhIJoSUJ/cqp4Z30mSmv9VUII7mGAD2IpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790404414; c=relaxed/simple;
	bh=67sOexwvNB8oNwHlLhm0JdMRdQfyPnVTudrDRY1E+3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JB2EIS+xRfIrc/xPgNwh2GJMbHLvzmzYELCvLJXRtPfq1bHsnyokIRWmNgLgiKgx8Nkl3rDAf1GruhGDh/AOxZdlyAhg0t/aqy61h2PdY373eR4i6PhOybrWufTJQQYrnnPgg5z0uFYMcamXHyZFrAhnaQpOG9nuR6qWzuuWRM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0IVx87Y; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0IVx87Y"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db22383fe8so6071045ad.2
        for <linux-block@vger.kernel.org>; Fri, 25 Sep 2026 23:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790404412; x=1791009212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v8XYO5YM5s3vZvbrjVcN9xgfREmdqmZ1B6r1XIDErl8=;
        b=F0IVx87Y/9+d1Wst+TMmPwJlaLnlHRKq3RYmtFQH9f5u7MeSNCJzqOv73+6FTrtxmH
         U0SHRRLPUkJEnBjjW0mLxhRy8NuVBRsVwjRinkj5eAaTsgtzAQ0smDPGQVf6+dTRH3U+
         rBiIpyY3AgUfei8fB00qgNKX7LHtcRghyPtRc1etjdi/3W5meNrDYj0yAChkc4Nb8l/H
         VGW/2gcfN7HRkKjtOiYwEaG4DFnZMqifiC2GfqV9DrJVUxbwe0I74wLX/6q4gKm9H2E2
         BNK/G6RNL2XfMspXD8dxkUAQundW5YMnp5lePPeZ+pYSia3DUuwl0ateA6G8fTXjz+f/
         tl8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790404412; x=1791009212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v8XYO5YM5s3vZvbrjVcN9xgfREmdqmZ1B6r1XIDErl8=;
        b=kzx6GTBkFX0T7/Tk6n1AroZxiWiSYya9hkMoH+H1fWeLfqdTQaZ3qn1jSw2pEinewF
         fsFKp97S/IKo/L7fEqJ3jkg6wJM6/EfdD7fvG0wwqnvaMimn/KTVYCShLXEduBOlR6mC
         Il1Gr8mCejNxJ9fyT1Z+Lh12yrL6Y/ckJPDj0c+8heB/XhkaByN/EfmLyWg+RVEQmZRE
         cED2PpJTNP/3npZuoMv9XQ1zOF+cTqWQ8efGJpjYkMTMMgQdnaY5tpjCRJXFu06FZMPw
         S1ymOCG2rXu+aznfL/yFxinjhbZLe679XA2JvxNlUfXpwwcuwtKQoetlwoUc04WMxmnu
         guDA==
X-Forwarded-Encrypted: i=1; AKwUvBwZ7Ws3Qs4e8KgRzS98cQ9EqcgrPv3e+pAtR92fCrADp/GPKhZ7vx9BXlW5v1PCT7eTN+R9J/UvCTQPtg==@vger.kernel.org
X-Gm-Message-State: AFq9FYJ6qwCaN4dLeCKAA5MTBeKEnBA2IxSQ1ICBoEQuGSM2sIKDlGpU
	GeVPCf4XFhJaSI8nfKrKyzMWbM2mM/dI6hlaL8F2sZ1aCQPxOl5DY7no
X-Gm-Gg: AYBFou23ASl351ZssEDN8f7bGYwnuLpPcOcXf95xDU/AlmmQIUXq1A48FinP2tC6vOc
	8OSMJ6EwQ1enX5176p7gpAZqRyDEgY/5CpFZQw+k41qTpq7QMUbZ25e0iTLOjWXab5CxWKVR978
	TnsjH7opw11MnVNgNUlOORgnsyVJ7a7C1uiMHgKBORZTmokjJWyucSllI1bJU3VirkZET4xqs5/
	64csi4/VILlL6OnwswSP0OIBlE9Iwl4QnbMHrF9SldUfXMo+Qb9ZaDcycDbwJy1pt7TVlQ8laok
	GU96X10z5Zuar3lKaIiMT6qWgS4gmvwMVr8IkBKJbBnyc2YHdPMBs4sKqQnC0fFUG1ry6ZGi9nh
	FfUS53QNw+aIOCgrSE0rrHINUpgZwQsjNONKQ5OwY+9vShvSPi3gkqnRebZG5DdE/PnmGKqdSx4
	jgJ4t7eCqDg0WvmnpBzF3So+X5r+oux8khhuTm3cpL/ISXtEU46wHVGRQVbphn1U40Bm2HOujpN
	vXRdAD3xgw9+Cd2osUof9gOvcJYjBqQPCkRGRpptYAh2r3QTs/z5oXBmcjW8UBQ1JpWUu5n43J8
	RxI=
X-Received: by 2002:a17:902:c404:b0:2dd:c0ff:e728 with SMTP id d9443c01a7336-2df7dfdda93mr62813445ad.58.1790404411724;
        Fri, 25 Sep 2026 23:33:31 -0700 (PDT)
Received: from yupeng-XPS-15-9520.. (c-73-169-192-12.hsd1.wa.comcast.net. [73.169.192.12])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df91460aaasm19196895ad.73.2026.09.25.23.33.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 23:33:31 -0700 (PDT)
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
Subject: [PATCH v5 0/2] nvmet: add cgroup_id to charge namespace I/O to a cgroup
Date: Fri, 25 Sep 2026 23:33:26 -0700
Message-ID: <20260926063328.257023-1-yupeng0921@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
  cgroup: export cgroup_e_css()
  nvmet: add cgroup_id to charge namespace I/O to a cgroup

 drivers/nvme/target/configfs.c    | 47 ++++++++++++++++++++++++
 drivers/nvme/target/core.c        | 54 ++++++++++++++++++++++++++++
 drivers/nvme/target/io-cmd-bdev.c | 18 +++++++++-
 drivers/nvme/target/io-cmd-file.c | 21 +++++++++--
 drivers/nvme/target/nvmet.h       | 59 +++++++++++++++++++++++++++++++
 drivers/nvme/target/zns.c         |  5 +++
 kernel/cgroup/cgroup.c            |  1 +
 7 files changed, 202 insertions(+), 3 deletions(-)


base-commit: d9cc476535d29a44df3f2aa3b14af9a833fddf90
-- 
2.53.0

