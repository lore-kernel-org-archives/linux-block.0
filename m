Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794570852;
	b=wGdROqicAKbBXvBT1feg4UvY7dXe9FLtoFbrtd8lDNxH2KgE45/YSJSNI6hpumty2d7E
	 f+gmhqKsXGF2gglcfzuWml7buxWP8pVtog1R7sWgxKOSG8OvaAg10uR+3cQYs2yfbbhcd
	 xTynbuo3mFiBHp5cqqNzWARBbzWL0w5MnFgIDi6uYOME6oHSpHQQ1dAZP+AF+/9mbWJjs
	 /cEHLSwkh+U97h3E+0tGqdrXocjnbDq4s+mG5mH4LY/UFm3pNr2fTwlh3Owq/zciuMTGt
	 mW+lynZyTlcgCpNivhTxn+lf1nseQUEOWc3J3+0tVH7k/8XuF7NzlxvZozZJaVIrL0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794570852;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=pbRQNC/WVjBouGeYLgSvMlHUmzi6srpGnSSFR5pP+sg=;
	b=H2/fkXE3/rx6jiwp0TZ84bIdliN/ctjOW1ODst9QXSQrI07Oe8NAv8n1hKWH8KyhO8/m
	 /w5nR0B7lqH3nAJngjquaXuS+AoERG3R7BqeajCEj1wfWtFZEBv7eVAHjhl4Sd0yqBtL5
	 rdWN7sWZcJEl4p98aPe/CTk6ORzSdTPsWeaiN4MplGZ+ksd6Kdd9YQJBb1A85erAa0KKg
	 nvCT3SxbSWn5+n4kXlOuuYbTDiYIIhrrzXN0qw3/ODP7eJupaTVf7sQ1owP4uoammxEJ2
	 HoXJktnX6izoI0syPTlfPj3kWBV2Udo8tAFc4qMQ7RVFxZBJWMd6hQyv2oLUlkofQTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=UGTY1T68;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BBF606A323;
	Fri, 13 Nov 2026 11:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59BBF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=UGTY1T68
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=pbRQNC/WVjBouGeYLgSvMlHUmzi6srpGnSSFR5pP+sg=; b=UGTY1T68C7djX9oqmTNd4tz9cJ
	96++LtaAb2E9nxp98Hu8cbMQY00U58HX7Fo5RFNb+OopMGTEXRKQa+6QVT8D4rEqwfN6oY3cr+dJn
	d9LAIfXHg0gIHs1kl6Y9LNs/yQm/U/5RFvp9N7/yOvUyNQHH9RX8EpckTNxIoFkY0tmFr7u9O4gxw
	VzzI+eoOpkIzwMyyqX7Xdotp00buJzqTo2C8OQbwZ7dWG2NLCKLEFPJsc6ql25mznXoVAYqiDF4K6
	kN66Pc+GOUDTe36kEuknPZ4yh3y9vrX/3Edydqg8K0P+oVZPtfOxzW/rWw0izN97rv8NzYYDtZJBG
	jrdRHHag==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xRpr7-00EjS0-24;
	Fri, 13 Nov 2026 11:54:09 +0000
From: Breno Leitao <leitao@debian.org>
Date: Fri, 13 Nov 2026 03:51:46 -0800
Subject: [PATCH RFC 3/3] fs/pipe: copy a run of anonymous buffers in one
 user access section
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
Message-Id: <20261113-pipe-pool-regression-smap-v1-3-b0dc69558ab3@debian.org>
References: <20261113-pipe-pool-regression-smap-v1-0-b0dc69558ab3@debian.org>
In-Reply-To: <20261113-pipe-pool-regression-smap-v1-0-b0dc69558ab3@debian.org>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
 x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-block@vger.kernel.org, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com, Mateusz Guzik <mjguzik@gmail.com>
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=4331; i=leitao@debian.org;
 h=from:subject:message-id; bh=jgyWomR4BFoO7Iiko0cteVrZz1ICwBdTp4pqsFhxR8A=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq9vpOprtwASD+S+AEDvCNdfixL2p7XamcAWZ12
 K9ozaNJCFmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavb6TgAKCRA1o5Of/Hh3
 bUslEACC3Q7BorrYuYXYpcylKDokvFOViVhUo9TTA9vNNMA5kmJIoL/fLRpjJ+V8hILWA/LZLNP
 5zJNHteqTmxeKpXk4udKkx1ucHMBT+xlrdWjV75YAfSRE3EeMwH4JmW7LwSw7I0q9uvb/Ij0eFZ
 FBsQZkZFOPxTYStIx5IYr3ql/q3bvk3YX49omqC58c9ZoQkmotb39BguPR1pSRFN2M6k/lh2OJQ
 5H9MsUbIOyREc8FJzbHfocnE6Zq7HB4VyTTk1s9a9bmvuomBCPp9UYBQiCPyb8wXFO31pZ1j051
 tWLqYRm0iNsO5myN4gCaj6iPJBsDUo8qTT03VykL3epXNcpGBsuH1rj43WQuktmYAVZBCUdsXRX
 YK8WM2qHkZsaaMucCs5LEZjyWwO1DiM6E3I+fA++YBK2B9sL9K0qxZtEr2ZjK5zJzuXJF1e71N4
 aRUyLyx8H4/OaiETwdDyiX2hVJIMTCZ4110FAd2SE3dx4RU9VIel1Te84DxIyCzyiqMtHIGqQFG
 zGxb2P4urDKGYlLYy8IkQ/WQT4XCHAZwCFfwrzivCee3Dpca/eILcmWcnklc6ABDADC7nyuDvKX
 nr5ihai+oFcRwtHcl7IZHdTzfEhZIWaBlDk1euXGtyVl+XGfBWdXnoT0p1i6/4NQ+04qTP10wdR
 HRVnx2kaTnlBElA==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

anon_pipe_read() copies one pipe_buffer per copy_page_to_iter() call.
On x86 every call opens and closes its own user access section, so a
64 KiB read that drains a full default pipe executes 16 STAC/CLAC pairs.

Hand up to PIPE_DEF_BUFFERS consecutive anonymous buffers that the read
consumes whole to copy_bvecs_to_iter_full(), then release them. That
includes buffers that splice() or tee() took from another pipe, which
keep anon_pipe_buf_ops.

A last buffer that the read takes only part of, packet buffers, and
buffers with other pipe_buf_operations, such as watch queue notes, page
cache pages and vmsplice()d pages, keep the buffer by buffer loop.

A fault inside the batch consumes nothing and leaves the buffers to the
existing loop, so short reads and -EFAULT behave as before. An injected
usercopy fault takes the same way out.

What this buys depends on what SMAP costs the CPU. With the buffer by
buffer loop, booting with clearcpuid=smap speeds pipe_bench up by 4-14%
on a Sapphire Rapids Xeon Gold 6450C.

pipe_bench from the pipe selftests runs 1, 2 or 5 writers against 1, 5
or 10 readers on one 1 MiB pipe, with 64 KiB writes and reads.

The numbers below come from an earlier version of this patch, which did
the copies in fs/pipe.c and left runs of a single buffer to the old
loop. Throughput change, median of 2 boots x 5 runs, SMAP on:

  writers  readers  Sapphire Rapids
        1        1           +5.2%
        1        5           +9.7%
        1       10           +8.7%
        2        1          +15.3%
        2        5           +8.4%
        2       10           +8.6%
        5        1          +11.9%
        5        5           +9.8%
        5       10           +8.0%

Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Link: https://lore.kernel.org/all/CAGudoHF3de_55YvdztPs7QiYs25u6nPEV=uMOzfr=bWmwof69g@mail.gmail.com/
Signed-off-by: Breno Leitao <leitao@debian.org>
---
 fs/pipe.c | 44 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/fs/pipe.c b/fs/pipe.c
index 29ae6c4a6c642c..a0d4c8b2f685bb 100644
--- a/fs/pipe.c
+++ b/fs/pipe.c
@@ -297,6 +297,40 @@ static inline unsigned int pipe_update_tail(struct pipe_inode_info *pipe,
 	return tail;
 }
 
+/*
+ * Read the anonymous buffers at @tail that the read consumes whole with one
+ * copy_bvecs_to_iter_full() call, which can copy them to a user buffer in one
+ * user access section. Returns the bytes read, or 0 to go buffer by buffer.
+ */
+static size_t anon_pipe_read_batch(struct pipe_inode_info *pipe,
+				   struct iov_iter *to, size_t total_len,
+				   unsigned int head, unsigned int *tailp,
+				   bool *wake_writer)
+{
+	struct bio_vec bv[PIPE_DEF_BUFFERS];
+	unsigned int tail = *tailp, n;
+	size_t len = 0;
+
+	for (n = 0; n < PIPE_DEF_BUFFERS && !pipe_empty(head, tail + n); n++) {
+		struct pipe_buffer *buf = pipe_buf(pipe, tail + n);
+
+		if (buf->ops != &anon_pipe_buf_ops ||
+		    (buf->flags & PIPE_BUF_FLAG_PACKET) ||
+		    buf->len > total_len - len)
+			break;
+		bvec_set_page(&bv[n], buf->page, buf->len, buf->offset);
+		len += buf->len;
+	}
+	if (!n || !copy_bvecs_to_iter_full(bv, n, to))
+		return 0;
+
+	*wake_writer |= pipe_full(head, tail, pipe->max_usage);
+	while (n--)
+		tail = pipe_update_tail(pipe, pipe_buf(pipe, tail), tail);
+	*tailp = tail;
+	return len;
+}
+
 static ssize_t
 anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 {
@@ -304,7 +338,7 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 	struct file *filp = iocb->ki_filp;
 	struct pipe_inode_info *pipe = filp->private_data;
 	bool wake_writer = false, wake_next_reader = false;
-	ssize_t ret;
+	ssize_t ret, batched;
 
 	/* Null read succeeds. */
 	if (unlikely(total_len == 0))
@@ -350,6 +384,14 @@ anon_pipe_read(struct kiocb *iocb, struct iov_iter *to)
 		}
 #endif
 
+		batched = anon_pipe_read_batch(pipe, to, total_len, head,
+					       &tail, &wake_writer);
+		if (batched) {
+			ret += batched;
+			total_len -= batched;
+			if (!total_len)
+				break;	/* common path: read succeeded */
+		}
 		if (!pipe_empty(head, tail)) {
 			struct pipe_buffer *buf = pipe_buf(pipe, tail);
 			size_t chars = buf->len;

-- 
2.53.1-Meta

