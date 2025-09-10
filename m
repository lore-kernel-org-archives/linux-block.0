Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF7DD244671
	for <linux-block@vger.kernel.org>; Wed, 10 Sep 2025 02:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757472239; cv=none; b=kn0aCvZsSjl7RATBKz+8DNiQ/XFDCyaqkCFm9GwJW30vNzc66qFVFQNmxZyF5OcC3LQsJfUztgoqqU8qvO3aTpGU5Q4J3f23RyS+J+s7ZqodLVGkX0Jg98uug8OLzPxn90PVjBaYqAuLBxwpRVW74sKnEvKGhCiBRrJFGVW7fXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757472239; c=relaxed/simple;
	bh=YkGAhUMgv4n62Z+ysk68FYvIotbnN4rNKVg76eclr+0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AlBuTesp66q5Q2IQ3EpgRDQJ1RCMfmoXRi4TLCzVxpPEz3j+Ovin1tRRQi3YO1f6Wx2RnXcIpypJjmRqH9/+z2gHlhbJoAnNxgWn/0MdQ0T3ksOvwsDWNJ6JhbVDSf709O1mU4n3ckc1wMKszpdVyiJ8T28fQW7pnpjAWyKojvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NPmFGVje; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NPmFGVje"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-25634c5ebdeso31062195ad.0
        for <linux-block@vger.kernel.org>; Tue, 09 Sep 2025 19:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757472236; x=1758077036; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7bLAL3/wNh9TSZolDjbNqAfIBJnmt2XQBMTZKVFm5qw=;
        b=NPmFGVje/xMIaQLO3+87zG+JJMLgBJTZdL/T6FRhetCHgfb3TJh6TlyJxBExw7MG+Y
         mk675xDzpTuojiN3CfNHaaApl06c+4M41VkuKa5gDL7qEeoayO7tzATA6a+PN8HhoAG9
         1U4LJ4b+zfTT6yodIIXxx2TxUCxboxnIgsTl2CnRlkLpwxyvFI2PI/65r2edzZ5RY/Up
         aKZI5I0VD3BO9w1MPPJvzPOmvPZOTJfxTKh4/wfQOKwYc0r/UaGcSl1JMnnpfFhZJuM+
         lSVf+5LAge+39zYh5yXSpH1UjfgB0GbP7/QhjyFhwmeZkh3x9z671Ytt1whAyr6Bku/X
         F/Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757472236; x=1758077036;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bLAL3/wNh9TSZolDjbNqAfIBJnmt2XQBMTZKVFm5qw=;
        b=MK0mnqrxc+4ja3Pe5NzFu3N8NhLzrRzrluXyRJFiz5DIYtKTYdqmAswahD8kf6sPJn
         59lGdrfrskVwJ5IHI4HPuX17gYV4PnmXzm8gZZmzhRaoHmxI6x+5uIhZSFLkGo/obUMQ
         p8mOkX/JIXLZIoPWFeLZRHO0qVGRZO8//zCtZH7VMY4GhKZDs8qwY8qYaGwIJxkEMY+S
         71tijDr487a+K0OOb5lOMw+bawhVXSeYYBqiQNHnCs4Mij8gIo78qQfewgDfIApFgx5L
         sOWnPcgRWm2eQCWcVLRU3lxBLhu7cdcdwMw5FWO/okT2nU0DcqgI9DsoZByRl60iYhW+
         t68A==
X-Forwarded-Encrypted: i=1; AJvYcCViDzyRbXxz0tD6Zm6Bjfl1RmZCBeXYtx0Gi8Md2kyJyblVaC2u0sZW3w8XwXg+WJpE1MxCIGg+yUXEDA==@vger.kernel.org
X-Gm-Message-State: AOJu0YySpn/tWgMA4VY/LihLi6lo7Xc3zBDEEhrqxpo7UcqY5NoxJQrW
	T2hQX94wLBW3toxSPxgZk8krDUgX4jqW+kB7CITmGUK/HrDHD3XU/o7z
X-Gm-Gg: ASbGncviANZb9sCuz/1ktC2XfnjM9kdQ6gW6fMIZbXwz3jPGuncUTtZ7sY9a+CQJOoI
	y91xjKT4UbJt0xlrs1OmBvCeMtegbSJqNsg7uf8N3MccDc01jPuLDUiZDVlHz4t3bFmopT/Q4RF
	VBBqdlLX0savt2dfhLvadIFfTNy4pPwzH/fmOXrCyXX8KxowpEvOvFJmpKEnkvTIu1H6y8BT6p1
	Ug2Ki2SwS5yFg/r/k+SU6fv3WjlMPRwP+TuLuRdUX4AcNHohIS4oj10Q9xqjlVZC1av5PkprWkQ
	ZdTCoAq8SN1ySPMow9smQnMIqcXAyzyEs9gO6wDiuHWHI+GtpJ9PYru5ltQqgfB2sS4QaBKM/kn
	hV2fg1CQyA5zRJGAy2TvB2sQrMIRXK9VMhzsw
X-Google-Smtp-Source: AGHT+IFGZSc9/jA9fPG6OfeDi4bv1kxrVTimgNKDvpjkwaVrL+5SueCfropq9o2yM0pmLNmhCmQCiQ==
X-Received: by 2002:a17:903:2350:b0:252:1d6e:df75 with SMTP id d9443c01a7336-2521d6ee123mr177310555ad.41.1757472236069;
        Tue, 09 Sep 2025 19:43:56 -0700 (PDT)
Received: from archie.me ([103.124.138.155])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dbb313dc5sm629853a91.1.2025.09.09.19.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Sep 2025 19:43:55 -0700 (PDT)
Received: by archie.me (Postfix, from userid 1000)
	id BD1A64206923; Wed, 10 Sep 2025 09:43:51 +0700 (WIB)
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux DAMON <damon@lists.linux.dev>,
	Linux Memory Management List <linux-mm@kvack.org>,
	Linux Power Management <linux-pm@vger.kernel.org>,
	Linux Block Devices <linux-block@vger.kernel.org>,
	Linux BPF <bpf@vger.kernel.org>,
	Linux Kernel Workflows <workflows@vger.kernel.org>,
	Linux KASAN <kasan-dev@googlegroups.com>,
	Linux Devicetree <devicetree@vger.kernel.org>,
	Linux fsverity <fsverity@lists.linux.dev>,
	Linux MTD <linux-mtd@lists.infradead.org>,
	Linux DRI Development <dri-devel@lists.freedesktop.org>,
	Linux Kernel Build System <linux-kbuild@vger.kernel.org>,
	Linux Networking <netdev@vger.kernel.org>,
	Linux Sound <linux-sound@vger.kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Peter Zijlstra <peterz@infradead.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Jonathan Corbet <corbet@lwn.net>,
	SeongJae Park <sj@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Huang Rui <ray.huang@amd.com>,
	"Gautham R. Shenoy" <gautham.shenoy@amd.com>,
	Mario Limonciello <mario.limonciello@amd.com>,
	Perry Yuan <perry.yuan@amd.com>,
	Jens Axboe <axboe@kernel.dk>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	KP Singh <kpsingh@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Hao Luo <haoluo@google.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Dwaipayan Ray <dwaipayanray1@gmail.com>,
	Lukas Bulwahn <lukas.bulwahn@gmail.com>,
	Joe Perches <joe@perches.com>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Alexander Potapenko <glider@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	tytso@mit.edu,
	Richard Weinberger <richard@nod.at>,
	Zhihao Cheng <chengzhihao1@huawei.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Nathan Chancellor <nathan@kernel.org>,
	Nicolas Schier <nicolas.schier@linux.dev>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Waiman Long <longman@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shay Agroskin <shayagr@amazon.com>,
	Arthur Kiyanovski <akiyano@amazon.com>,
	David Arinzon <darinzon@amazon.com>,
	Saeed Bishara <saeedb@amazon.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Alexandru Ciobotaru <alcioa@amazon.com>,
	The AWS Nitro Enclaves Team <aws-nitro-enclaves-devel@amazon.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Ranganath V N <vnranganath.20@gmail.com>,
	Steve French <stfrench@microsoft.com>,
	Meetakshi Setiya <msetiya@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Bart Van Assche <bvanassche@acm.org>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
	Jani Nikula <jani.nikula@intel.com>
Subject: [PATCH v2 00/13] Internalize www.kernel.org/doc cross-references
Date: Wed, 10 Sep 2025 09:43:15 +0700
Message-ID: <20250910024328.17911-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3670; i=bagasdotme@gmail.com; h=from:subject; bh=YkGAhUMgv4n62Z+ysk68FYvIotbnN4rNKVg76eclr+0=; b=owGbwMvMwCX2bWenZ2ig32LG02pJDBkHnkjdCX+kN/Vk8dEtTx4oXHJVUlr871/34wNfprkGL ftS0Hh2bkcpC4MYF4OsmCLLpES+ptO7jEQutK91hJnDygQyhIGLUwAmss2M4X9W7lbP1sh5f5RO Hw1mqOzaUvQkVGr5Yv7A7uJI7gMzyrwZ/nD+Ytx+cpXRX/eb/x2rj6W/XClZe5lBR2mP0knB37f n7WUAAA==
X-Developer-Key: i=bagasdotme@gmail.com; a=openpgp; fpr=701B806FDCA5D3A58FFB8F7D7C276C64A5E44A1D
Content-Transfer-Encoding: 8bit

Cross-references to other docs (so-called internal links) are typically
done following Documentation/doc-guide/sphinx.rst: either simply write
the target docs (preferred) or use :doc: or :ref: reST directives (for
use-cases like having anchor text or cross-referencing sections). In
some places, however, links to https://www.kernel.org/doc are used
instead (outgoing, external links), owing inconsistency as these
requires Internet connection only to see docs that otherwise can be
accessed locally (after building with ``make htmldocs``).

Convert such external links to internal links, while keeping the
original anchor texts using :doc: directive. Note that this does not
cover docs.kernel.org links nor touching Documentation/tools (as docs
containing external links are in manpages).

This series is based on docs-next tree. Maintainers can feel free to
apply any of patches in this series to their own tree.

Changes since v1 [1]:

  * Apply review tags
  * Drop patch [12/14] as it has been applied to sound tree

[1]: https://lore.kernel.org/linux-doc/20250829075524.45635-1-bagasdotme@gmail.com/

Bagas Sanjaya (13):
  Documentation: hw-vuln: l1tf: Convert kernel docs external links
  Documentation: damon: reclaim: Convert "Free Page Reporting" citation
    link
  Documentation: perf-security: Convert security credentials
    bibliography link
  Documentation: amd-pstate: Use internal link to kselftest
  Documentation: blk-mq: Convert block layer docs external links
  Documentation: bpf: Convert external kernel docs link
  Documentation: kasan: Use internal link to kunit
  Documentation: gpu: Use internal link to kunit
  Documentation: filesystems: Fix stale reference to device-mapper docs
  Documentation: smb: smbdirect: Convert KSMBD docs link
  Documentation: net: Convert external kernel networking docs
  nitro_enclaves: Use internal cross-reference for kernel docs links
  Documentation: checkpatch: Convert kernel docs references

 Documentation/admin-guide/hw-vuln/l1tf.rst    |   9 +-
 .../admin-guide/mm/damon/reclaim.rst          |   2 +-
 Documentation/admin-guide/perf-security.rst   |   2 +-
 Documentation/admin-guide/pm/amd-pstate.rst   |   3 +-
 Documentation/block/blk-mq.rst                |  23 ++--
 Documentation/bpf/bpf_iterators.rst           |   3 +-
 Documentation/bpf/map_xskmap.rst              |   5 +-
 Documentation/dev-tools/checkpatch.rst        | 121 ++++++++++++------
 Documentation/dev-tools/kasan.rst             |   6 +-
 .../bindings/submitting-patches.rst           |   2 +
 .../driver-api/driver-model/device.rst        |   2 +
 Documentation/filesystems/fsverity.rst        |  11 +-
 Documentation/filesystems/smb/smbdirect.rst   |   4 +-
 Documentation/filesystems/sysfs.rst           |   2 +
 .../filesystems/ubifs-authentication.rst      |   4 +-
 Documentation/gpu/todo.rst                    |   6 +-
 Documentation/kbuild/reproducible-builds.rst  |   2 +
 Documentation/locking/lockdep-design.rst      |   2 +
 .../can/ctu/ctucanfd-driver.rst               |   3 +-
 .../device_drivers/ethernet/amazon/ena.rst    |   4 +-
 Documentation/networking/ethtool-netlink.rst  |   3 +-
 Documentation/networking/snmp_counter.rst     |  12 +-
 Documentation/process/coding-style.rst        |  15 +++
 Documentation/process/deprecated.rst          |   4 +
 Documentation/process/submitting-patches.rst  |   4 +
 Documentation/virt/ne_overview.rst            |  10 +-
 26 files changed, 161 insertions(+), 103 deletions(-)


base-commit: f44a29784f685804d9970cfb0d3439c9e30981d7
-- 
An old man doll... just what I always wanted! - Clara

