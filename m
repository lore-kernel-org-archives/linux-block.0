Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F313749EB
	for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 08:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789981123; cv=none; b=WkLu9Am7Rj6Y4X7FlqkzwfC+4+0Wh7FCZxRGamMawDMwpTfY9cb0UnX0Wf3xFs47nnwYcHAx+qkveweIQf9LegCpO0HdAYC6V93HCJAfC2sD5NX+IjTsicyIldZdcJdyxAT/bAa8eEDuKks1Br1ANBn9QwId/a/Sm3+sucpzSTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789981123; c=relaxed/simple;
	bh=aIsP5pjusofG2bkFDvi2m9NLFLU7a0nBS1IBQI+MgAc=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=NK5tbq6z4LiFWoWmBa+bLjr/JQGWjqz4lVAfae9agLoIKsdyJYEQwOvHLjwuIPafmadXeOeCxVNiLV49zMj1zjhmx+UZipAIhJB/XT72EcYcChYe+pjuxVfWcVYlsPS3vKon0p2nUQzTjT+pLFtegsIIlZppl/c4NPv+qOB/xO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=0b1t.tech; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=0b1t.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109f067fso383672785a.2
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 01:58:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789981121; x=1790585921;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=fv5dUFJYeEL+EEWsTjP2Mf6LiG1JqaunSC2gFYFmivM=;
        b=GJnXv2JqpkLrhFvViv18UbHYQWv0fLS545HOzHo/rwZfsMBoutO77cmSmngZzqSxC+
         gRCVPcK3SHbKMOf942keRRpxSS6MvZB4b8SA3N9Ns+2yFHEn12+PwJ7bc8NjvdgOYghJ
         F4buPJpfCYPxdqQbr7uniV4UlQIzBdSLQSgnWiLhNrxKGSutL2gVXF1b5YX1e1sG90kK
         kq8Y40mJEeFUvXEJqnDDrurGsinDScZ21323ByOfDEXQqNNbzeAwt6c5pwMAOSFkgu35
         wuE7WPzN3O0RisR51D9JD9Vq2IifKQgY1uIq9VvDWCFmJ6UMSYYIvifRT/yQRu6uU+9g
         2iJQ==
X-Gm-Message-State: AFuF++mFssZayYybRvZFT9DXHZrwGwYi2w8Yburu4Ys1vXavmu3GiBbt
	6GG8Q5bg66qu/Fm8/a5pUyV4GZa78olvdnB5kTT56ZEJ8PVZJdjdmVT1AvTo7OGKXd4TXQ==
X-Gm-Gg: AYBFou26OgAunYcW0tDr0wtoqdA0cQHzihRr7SCPDG7zit5zBRdqDYSN24K71xPyCBX
	KL7ydpacdQkDMXLBLDiC1X0rttePwkC0fsTGhAxu/wKrJ4lsLkC29vRPxI/65N2eNrx0zNrj0ad
	GwblGpxFeIMsSCDcbzQDh6MXKWtC9Ll1B/w7KbtvGjpEtk/Szo9CUiQ2SCa21i1RF9y3GjT0VNs
	8J8z98OXd19H3HE2bNF3hOhA5HWY/kUMCqtqxLBNr5WWJjl8ZAOZV90Ux6SHNaPFd4aJNRBiI+g
	UikhgmzKTm7tHH9dxDi922S7C/HAsk+mQpr1d/fDp7LQAQR3QJksR+cQxUVANQLqyak3sMqw/su
	9mHKE0OaFyMaoXKXhyTZMqtI7/Wr5U850k2GsO/gVxGzeOnVHs9GTlT1XoACIQ3YNwXych7RSg/
	LzcPmXEQHIV6FkJVEP+NP6vL9Pw47wy2YNkbkoC3eAP6ZUS0MqcjkRGvhMPR4rUHcjyFPV4B5Bl
	xsSUljSqxhu5OG9LKGLbMQmuaj+
X-Received: by 2002:a05:620a:45a5:b0:93b:eac0:ddd5 with SMTP id af79cd13be357-93bf5785d9emr824617285a.51.1789981120991;
        Mon, 21 Sep 2026 01:58:40 -0700 (PDT)
Received: from mail-qv2-f12.google.com (mail-qv2-f12.google.com. [74.125.230.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91260962b9fsm63309216d6.5.2026.09.21.01.58.40
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Sep 2026 01:58:40 -0700 (PDT)
Received: by mail-qv2-f12.google.com with SMTP id 6a1803df08f44-9104e54b1abso40598926d6.1
        for <linux-block@vger.kernel.org>; Mon, 21 Sep 2026 01:58:40 -0700 (PDT)
X-Received: by 2002:a05:6214:f22:b0:910:7076:b681 with SMTP id
 6a1803df08f44-9129c7568f1mr103728486d6.2.1789981120658; Mon, 21 Sep 2026
 01:58:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: 0wnerD1ed <l7z@0b1t.tech>
Date: Mon, 21 Sep 2026 16:58:29 +0800
X-Gmail-Original-Message-ID: <CAKTh27_iPvKWV8_bLMwwhEZAD+XPXimBdpz4D8iuue8mSh2A=g@mail.gmail.com>
X-Gm-Features: AcwNN1VpCMJACs5QMY5o1_pa7XIKz3bMqA0dJWElfoP6NrKq9mJCEF2x9o4Nz_M
Message-ID: <CAKTh27_iPvKWV8_bLMwwhEZAD+XPXimBdpz4D8iuue8mSh2A=g@mail.gmail.com>
Subject: [PATCH blktests] block/046: skip with the new XFS read-bounce implementation
To: "Shin'ichiro Kawasaki" <shinichiro.kawasaki@wdc.com>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"

block/046 uses a deliberately misaligned one-byte iovec to exercise the
special bvec layout in bio_iov_iter_bounce_read().

The new XFS lazy read-bounce implementation no longer sets
IOMAP_DIO_BOUNCE before extracting the user pages.  The ordinary path now
rejects that iovec with EINVAL, and a later patch removes the legacy helper
entirely.

Detect the per-mount csum/read_bounce interface and mark the test not run
after cleaning up the XFS mount and null_blk device.  This retains the
regression coverage on older kernels without treating the expected EINVAL
as a successful result.

Reported-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Link: https://lore.kernel.org/r/arDN1UdZIydNLUjz@shinmob
Link: https://lore.kernel.org/r/20260921082240.GA19833@lst.de
Signed-off-by: 0wnerD1ed <l7z@0b1t.tech>
---
 tests/block/046 | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/tests/block/046 b/tests/block/046
index 5f874bc..e97f583 100755
--- a/tests/block/046
+++ b/tests/block/046
@@ -23,6 +23,7 @@ requires() {
 test() {
        local block_size
        local mount_dir="${TMPDIR}/mnt"
+       local read_bounce="/sys/fs/xfs/nullb1/csum/read_bounce"
        local test_file="${mount_dir}/target"

        echo "Running ${TEST_NAME}"
@@ -42,6 +43,24 @@ test() {
                _exit_null_blk
                return
        fi
+
+       # The lazy XFS read-bounce implementation replaced the legacy
block-layer
+       # path whose special bvec layout this test exercises.
+       if [[ -e "${read_bounce}" ]]; then
+               if ! umount "${mount_dir}" >>"${FULL}" 2>&1; then
+                       echo "failed to unmount XFS"
+                       _exit_null_blk
+                       return 1
+               fi
+               rm -rf "${mount_dir}"
+               if ! _exit_null_blk; then
+                       echo "failed to remove null_blk"
+                       return 1
+               fi
+               SKIP_REASONS+=("legacy read-bounce implementation is
not present")
+               return
+       fi
+
        dd if=/dev/zero of="${test_file}" bs=1M count=1 conv=fsync \
                status=none
        block_size=$(blockdev --getss /dev/nullb1)
--
2.54.0
