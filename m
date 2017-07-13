Return-Path: <salyzyn@android.com>
Return-Path: <salyzyn@android.com>
From: Mark Salyzyn <salyzyn@android.com>
To: linux-kernel@vger.kernel.org
Cc: Mark Salyzyn <salyzyn@android.com>,
	Davidlohr Bueso <dave@stgolabs.net>,
	Jens Axboe <axboe@kernel.dk>,
	linux-efi@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH] efi: add gpt_overprovisioned kernel command line parameter
Date: Thu, 13 Jul 2017 15:21:04 -0700
Message-Id: <20170713222137.11529-1-salyzyn@android.com>
List-ID: <linux-block@vger.kernel.org>

Allow a gpt partition table to be used if it is overprovisioned, the
last usable lba in the GPT headers is beyond the device boundaries.
This feature is enabled if gpt_overprovisioned is added to the kernel
command line.  It will not expose any individual partitions that go
beyond the device boundaries, just the ones that are under that limit.

Default off, one can perform an exploratory boot of the kernel and
triage or backup the properly provisioned partitions.  This would
allow the system to at least partially boot. For example if the boot,
root or system filesystems reside on properly provisioned partitions.

Examples, helpful should a RAID array be resized downwards, or
during embedded development should an overprovisioned partition
table update be flashed to a device by accident.

Signed-off-by: Mark Salyzyn <salyzyn@android.com>
---
 block/partitions/efi.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/partitions/efi.c b/block/partitions/efi.c
index 39f70d968754..e18ee5cf138c 100644
--- a/block/partitions/efi.c
+++ b/block/partitions/efi.c
@@ -117,6 +117,15 @@ force_gpt_fn(char *str)
 }
 __setup("gpt", force_gpt_fn);
 
+static int overprovisioned_gpt;
+static int __init
+overprovisioned_gpt_fn(char *str)
+{
+	overprovisioned_gpt = 1;
+	return 1;
+}
+__setup("gpt_overprovisioned", overprovisioned_gpt_fn);
+
 
 /**
  * efi_crc32() - EFI version of crc32 function
@@ -420,7 +429,8 @@ static int is_gpt_valid(struct parsed_partitions *state, u64 lba,
 		pr_debug("GPT: last_usable_lba incorrect: %lld > %lld\n",
 			 (unsigned long long)le64_to_cpu((*gpt)->last_usable_lba),
 			 (unsigned long long)lastlba);
-		goto fail;
+		if (!overprovisioned_gpt)
+			goto fail;
 	}
 	if (le64_to_cpu((*gpt)->last_usable_lba) < le64_to_cpu((*gpt)->first_usable_lba)) {
 		pr_debug("GPT: last_usable_lba incorrect: %lld > %lld\n",
-- 
2.13.2.932.g7449e964c-goog
