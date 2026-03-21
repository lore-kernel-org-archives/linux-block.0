Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D58883176EF
	for <linux-block@vger.kernel.org>; Sat, 21 Mar 2026 13:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774098006; cv=pass; b=NGfHDORXdSE2le8Vif7TaB7NMqQRXXsjPExdhU10EmSKKKsDNPpKqRw8V8+cDewXtkD8X9zJfP/9qq/OGe4jev9Hhc+Wqo1ATrTqRe9mdgcxLoydQPKaiC/kUbHWK+Z1+X9bCx9THX/3LcEY3gVC+hwZGMgRBJUYOT8e4gYOpAY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774098006; c=relaxed/simple;
	bh=CTaIqIBFIA6pi+cP3QOq7Q9L4YHN3NX1A7us/XizAXw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=d9UecvRICDjHI5EdTps3KJlVjt5MTEySdjZXKh3SCFbUB9YCCi41mMD+koSQJh8ljD/LGyi90y/o9HKlNwZjXFSZQsdtgEmgniefy/tNnPKlP66p+WoITYJ1LSWzEi34sDg4FELjRoHDg8OWDWlgkmlGoCogzE+DO8HAAasRWFQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Krt1zCBB; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=aBkCR1k6; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Krt1zCBB";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="aBkCR1k6"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774098003;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Fpbs8XKDfDNQTyz41ElS+DRL3VdtzXxmCp20GhbayqU=;
	b=Krt1zCBB1xE0YmmbLSh5f6vtiYqKcgpdCDkbKTXq+vN+zjo0UoXXTh6qS51qZr3/WcUYt8
	wqPTm2X3nLg8+fk24KfrDbmGLzPYbvfQsHzxr1WO75UGhk7aGu7TWOXOffg7NN/AODi76O
	nPbFpqClYqjVzkVqQCC/UxVPz2FNhJ8=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-bhSyS9y4Pc2DTdmqJclvVg-1; Sat, 21 Mar 2026 09:00:02 -0400
X-MC-Unique: bhSyS9y4Pc2DTdmqJclvVg-1
X-Mimecast-MFC-AGG-ID: bhSyS9y4Pc2DTdmqJclvVg_1774098000
Received: by mail-lf1-f71.google.com with SMTP id 2adb3069b0e04-59e28288067so2162614e87.2
        for <linux-block@vger.kernel.org>; Sat, 21 Mar 2026 06:00:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774097999; cv=none;
        d=google.com; s=arc-20240605;
        b=iQDeFZwAqFt/YOJCsz8OPoQkYSJEhXSOC76Mvmgkagql2OG7qm47uvX2l6Wtp8cPQc
         9msyNJ5EDYwXRjOsCMcTaLQstUfs0dihp7cUhAW+KN7iD02pK3pI3c0DQNYuzdWVsswF
         Ub1X1SqoHdqvlP5LJho87PdhOzh6Z3wk+7sS9Ysr6guBUTZdf+5WE2XVGqnKZ+kCwQ9l
         uDu71FFwO7g2/lVIaBdQzCVTnT7QOUCwbtGfPP/AsF2+5jEWaFQeFzcEwAAQ29FgN5Um
         aK7OSMgLm2KrlUoT42XNxXB8Kp2Q1ls+jHxswMBClk/SdzivTHOvllowzi1MoBLLw9Q4
         at1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=Fpbs8XKDfDNQTyz41ElS+DRL3VdtzXxmCp20GhbayqU=;
        fh=DyWa9vFJ6CrGea9tuenLRRPHDIULoWrow40H3zm7JTM=;
        b=aG0hb+2ECU8h5zOHvP/iYPd2kHOhpKQjIvbi440OzHgjY5f6InogZ0D3Py9YDZDWDz
         S3RyxhJ0PLL8xJKsubGhx79eo4lfhpivBcKKsIImFHcTJkMHzLsY7RcUGczWnn4w4/D3
         WTXqcximbEZbQ6+yDGU/XX/+8KirIH1kXhbMsmCOjkZaYEWFAetrgSNlmWYNDXBAlBj/
         f+XQxT9Fvgl0ZckCxuWBXcHp0pFWnaM1jsu5Ql02rivTXB45jYeb/E219Zy57S567o1L
         VPSGkZG5ENXIwz1p4dH8kjGYhTqHJC822mpzyXiEIJh7AYyfhVyujEME2yAIhe6FqvPm
         ITMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1774097999; x=1774702799; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Fpbs8XKDfDNQTyz41ElS+DRL3VdtzXxmCp20GhbayqU=;
        b=aBkCR1k6E5JOyw+u6AiMbD58ZUnxqvebYwlROd6nezs/oyDHxYTUvQzJqnF4kHAj0s
         gQrCHVPwqyqq3LYrUAGAGEZ+Jl/QdUQi4YkuwQE4C1ufrtcoAgn5KQeVNHkjb8BcT0G3
         DYEgR1si/vi7FujVbXqmM5AGCCNEpO1DoW+/YC65En0CyQDUxrPWdFgSEjITXHrpZa8e
         +t+qdjxSj99gOW5LmhqkGToYxk9H7FC328QmuZFNd68RaudrcqES87Cz5A/3Mrf+8RRx
         XjDuLxEJKeLGJwLGsOEgViYW9bHNoMza6GsF51ToEumC1OrpqFp3yOYeF7V7dIqGse5M
         gzow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774097999; x=1774702799;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Fpbs8XKDfDNQTyz41ElS+DRL3VdtzXxmCp20GhbayqU=;
        b=G01azt4FLhl5blLZL6jF0k61nwGzKx785oTIvkxU8lqC+iIe9HVuP5a0OpPGwSS4P0
         CERThXkJEE6twjqKvmMmNuiIRf2s73dS6PtV1rlmpAudDJrE7Ax75M/7JhUgLKq/FIBF
         AIgs2lVfS5H2dmxv1qdDEq7vjdAR2jKaUEqkQxR++nXC69cpM6NKkZ6Ls1ogC1c94DKv
         1azycM5brIC3dVhA3+Vm83pGMLDiterhbeVpTy65WPHZXNPuUTCSoUg3ljLA58DqaTY3
         HzUzTLyW4Yf0UnE2obC6+HFoYvj0ahB9+ixWayfx33ZSgtoJJy8esF5vnrj5LweIIPCL
         XPBg==
X-Gm-Message-State: AOJu0YzEnHJ0pHKlio6Yw7Uee8MnsGtASW9QKwOTGL2ZLqO2COpRogWY
	+nSd7RBmYYJm+xuNRsOCtjNuwDzTOUQxkC4yLIWZomnaXaEo9kKYqgCxLv+eJr2On3c8bThcAnL
	5FPdBucNWB4NaY8iX1beAkQVYFreq1cy9wxv7XzAViOrGk7WrMS6AzpLWvO9MUCa3pKGBP7UmTb
	s80q61Pi0kVozkF0jhiigMxGZDS1ltugUJrNDShf4hBnepr0nFNBCF
X-Gm-Gg: ATEYQzw/OE8VWeVbGZ0WvQ3PfRE22TYTGqPRlyVRhQxztf39FaQstaBixfUeBUgSNFb
	ee6ujZvtl1dVLDE9iN4eV/Us6rKM16wB26lzWzYzJzzauvzpd3c0To1P27I3L/qFFwFKTNymhFv
	kt8yWO+avATcsGhY+cAJSD2BXdq0nZiCCihOCDoSOHluuimvyBlwFxsoXtHgGnE+V9R1GAAdsb7
	gkuqXoWvieA+//Im173dnLtJHNtzDB/UdQCed05TPRps11HDXc=
X-Received: by 2002:a05:6512:3b13:b0:5a2:77d4:1043 with SMTP id 2adb3069b0e04-5a285b54b7dmr2161528e87.22.1774097998585;
        Sat, 21 Mar 2026 05:59:58 -0700 (PDT)
X-Received: by 2002:a05:6512:3b13:b0:5a2:77d4:1043 with SMTP id
 2adb3069b0e04-5a285b54b7dmr2161516e87.22.1774097998114; Sat, 21 Mar 2026
 05:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Yi Zhang <yi.zhang@redhat.com>
Date: Sat, 21 Mar 2026 20:59:44 +0800
X-Gm-Features: AaiRm53nCjG1SMtYW6vATYs1MPuPXdKMcmY1xxod-_bWiOlq2HPekrZ5kufAKj4
Message-ID: <CAHj4cs_mRpS=uqW=2NF8RdzW2jjgu+3LhmCFiSK2kahRmTS-tw@mail.gmail.com>
Subject: [bug report] blktests rnbd/001 hang on s390x server
To: linux-block <linux-block@vger.kernel.org>
Cc: haris.iqbal@ionos.com, jinpu.wang@ionos.com, 
	Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>, 
	"Zhijian Li (Fujitsu)" <lizhijian@fujitsu.com>
Content-Type: text/plain; charset="UTF-8"

Hi

I found this issue when I running blktests rnbd/ on s390x server,
please help check it and let me know if you need any info, thanks.

dmesg:
[   72.319120] rdma_rxe: loaded
[   72.358181] rtrs_server L2371: Loading module rtrs_server, proto
2.0: (max_chunk_size: 131072 (pure IO 126976, headers 4096) ,
sess_queue_depth: 512, always_invalidate: 1)
[   72.380277] loop: module loaded
[   72.399060] run blktests rnbd/001 at 2026-03-21 08:42:02
[   72.408570] infiniband enc600_rxe: set active
[   72.408573] infiniband enc600_rxe: added enc600
[   72.422914] rnbd_client L607: Mapping device /dev/loop0 on session
blktest, (access_mode: rw, nr_poll_queues: 0)
[   72.488056] rnbd_client L1192: [session=blktest] mapped 2/2
default/read queues.
[   72.488199] rtrs_server L1058: <blktest>: Processing read request
failed, invalid message

# uname -r
7.0.0-0.rc4.260317g2d1373e4246d.37.fc45.s390x

# ps aux | grep rnbd
root        1492  0.0  0.0   8276  4436 pts/0    S+   08:42   0:00
/bin/bash ./check rnbd/001
root        1521  0.0  0.0   8288  3292 pts/0    S+   08:42   0:00
/bin/bash ./check rnbd/001
root        1523  0.0  0.0   8424  3664 pts/0    D+   08:42   0:00
/bin/bash ./check rnbd/001

# cat /proc/1523/stack
[<0>] send_usr_msg+0x120/0x170 [rnbd_client]
[<0>] send_msg_sess_info+0x1d2/0x210 [rnbd_client]
[<0>] find_and_get_or_create_sess+0x274/0x2f0 [rnbd_client]
[<0>] rnbd_clt_map_device+0xf6/0x7b0 [rnbd_client]
[<0>] rnbd_clt_map_device_store+0x228/0x320 [rnbd_client]
[<0>] kernfs_fop_write_iter+0x168/0x220
[<0>] vfs_write+0x282/0x450
[<0>] ksys_write+0x84/0x110
[<0>] __do_syscall+0x166/0x600
[<0>] system_call+0x6e/0x90

-- 
Best Regards,
  Yi Zhang

