Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E337D11C;
	Wed, 20 May 2026 08:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779264971; cv=none; b=hC24cHAZC3GiUiwaGQjubcXPX9t8dCuN1zaRjiNNwKNAKsT2RP9sng8YVS23Z9K/+xBcWL0gS+Nzk3p+lwKfguwcdT81pmRDGLkqwq91Qe4LlU+i2PMmmBs5tuQVc2GqLgQJvrWrRPXkg03kvp2trhJUdNahQY/2JapND4RaqCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779264971; c=relaxed/simple;
	bh=iVaqBtFYBCE5KYG/yGAvVZf7o0sXkVHrzQo9ScdcIiA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=tKmKhwRS0/o6MjYxjYCIXlW2UM/OuHsk+A9U2VK7MOuhGD/A4CLBloGblRxxwyHh6qTBwLwspECAuqolz3B4IpEK46P/pkpLDRWkdkNAnqIIqKVcJrk6QGy9p6I2nbM2B150RlqWRl19Oi5ftNyI0xeVjdo6y391pzm16pju/OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DrFPXo7B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DrFPXo7B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 278B51F000E9;
	Wed, 20 May 2026 08:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779264970;
	bh=8cLE9GJnLxVk1PO/q0NbGrn9yaBQPal5piuLn9fXCpo=;
	h=From:Date:Subject:To:Cc;
	b=DrFPXo7B++pdx3NrXXms9mMsON/Ok7u2SsjXcACX1DaKEI1JD2MdNdgKjQiBy1iP+
	 gKv8O9DPKetOJstx20jQX1sP7IJx7t1y/HR7J/AqWicvkNkRpSTxKT/f1dsN8sw3cy
	 uB1KHEzTX5jjmXDf0d1BsS9bfMxA4D+W94p2fmkNxdjhgprzSuT/Wl6RgNpdgagFss
	 dY0KYxEtWhwqIa0LZs9up/9z0/yeMF4GViFaHt2xNttm2IUhfxnxMeL6pqNp17CvHM
	 m0+NFDUXYb2TCQKpHX9wfRI1CsA6hm8pIBQq59YqkeFQqWV7IsxSrcgf2akTPijpHm
	 1y/+tO++sgJfw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Wed, 20 May 2026 11:15:52 +0300
Subject: [PATCH] block: partitions: replace __get_free_page() with
 kmalloc()
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260520-block-v1-1-6463dc2cf042@kernel.org>
X-B4-Tracking: v=1; b=H4sIALdtDWoC/yWMQQ6DIBBFr2Jm3Ukphtb0Ko0LwEGpFgxjGxPj3
 QW7fD/vvw2YkieGZ7VBop9nH0OG26UCO+jQE/ouM0gh70JJgWaKdkSpVCMfqnZd3UB250TOr2f
 n1f6Zv+ZNdinnYhjNhCbpYIcy9W7GJeL40VMOXs8q7PsB2IcTPpAAAAA=
X-Change-ID: 20260520-block-25582753fd38
To: Jens Axboe <axboe@kernel.dk>
Cc: Mike Rapoport <rppt@kernel.org>, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2038; i=rppt@kernel.org;
 h=from:subject:message-id; bh=iVaqBtFYBCE5KYG/yGAvVZf7o0sXkVHrzQo9ScdcIiA=;
 b=owEBbQGS/pANAwAKATkDhibLDv2RAcsmYgBqDW3FFxdymUm74+B5Ltlyqex2ijloRdLMdORm0
 p2SqhAPO8uJATMEAAEKAB0WIQR45VhVpZkvn3TRr+k5A4Ymyw79kQUCag1txQAKCRA5A4Ymyw79
 kbSfB/40Fp7YEG2dDGt/X0/HW800n7ahFnLVCASurAwFITkTWouSdJmXfW7Q5yN3DXeXpe7J9fY
 5LiCpvqfIomNQY9GNKwa0SDRYb9MMZPD8/l5ovQYoeNqAyE/ZkkHl+PZTzsfXuIgxqnfpIrtbxY
 WK/+VhPxvau9u+gBYousFs8a73T2fMNNt6zjC44KpXn61rrV/nXt1iSZcGhTmOL8ZD4X1uyRWpd
 Lpirl5zEla1UoklSDYdvwq9Wtv0blWB6gIbr7zbhUmwLNmhUYE18DVXzo29rYjwprjXWIoaZKMI
 oILc8Tg+Dkp5URyIzO1PO1Uin9i1qO8d0EFxo9zsilFDYIAz
X-Developer-Key: i=rppt@kernel.org; a=openpgp;
 fpr=B8E96E880C4A40C3C1255AA8C532392DE6DA7CE9

check_partition() allocates a buffer to use as backing buffer for
seq_buf.

This buffer can be allocated with kmalloc() as there's nothing special
about it to go directly to the page allocator.

Replace use of __get_free_page() with kmalloc() and free_page() with
kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
This is a (tiny) part of larger work of replacing page allocator calls
with kmalloc:

Also in git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/block

Signed-off-by: Mike Rapoport <rppt@kernel.org>
---
 block/partitions/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/partitions/core.c b/block/partitions/core.c
index 5d5332ce586b..b5c59b79ca7c 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -124,7 +124,7 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
 	state = allocate_partitions(hd);
 	if (!state)
 		return NULL;
-	state->pp_buf.buffer = (char *)__get_free_page(GFP_KERNEL);
+	state->pp_buf.buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
 	if (!state->pp_buf.buffer) {
 		free_partitions(state);
 		return NULL;
@@ -154,7 +154,7 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
 	if (res > 0) {
 		printk(KERN_INFO "%s", seq_buf_str(&state->pp_buf));
 
-		free_page((unsigned long)state->pp_buf.buffer);
+		kfree(state->pp_buf.buffer);
 		return state;
 	}
 	if (state->access_beyond_eod)
@@ -170,7 +170,7 @@ static struct parsed_partitions *check_partition(struct gendisk *hd)
 		printk(KERN_INFO "%s", seq_buf_str(&state->pp_buf));
 	}
 
-	free_page((unsigned long)state->pp_buf.buffer);
+	kfree(state->pp_buf.buffer);
 	free_partitions(state);
 	return ERR_PTR(res);
 }

---
base-commit: 5d6919055dec134de3c40167a490f33c74c12581
change-id: 20260520-block-25582753fd38

Best regards,
--  
Sincerely yours,
Mike.

