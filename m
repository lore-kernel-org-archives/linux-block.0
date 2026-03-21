Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BA51A682C
	for <linux-block@vger.kernel.org>; Sat, 21 Mar 2026 08:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774081370; cv=none; b=gGUMe1lIkqTuXEAdBesY4otkTEvc1l4ht+5391nEYacz33WmmLe4ov57Xq1KiTXeWMPU7vI7MJB4cY1jWS8fNTOqo92Q/JKBl9CJucq7QCDNohLUih1d5anTAYDLzd5I75117j1z9i4FirgXvUT7Oigj36eOyL/TYcwd3AZ6vxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774081370; c=relaxed/simple;
	bh=o185dR7GcK1G3JlJOBtrgm1Du+CxvHKqi/LdjToWpDQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nd8qnwmGV31achREx/3w4Ikgp8hnpMKGju6QjHbt57AqLlyOuBgUyFTz6emIb+WeKF5J6pRoB6g6JpLgo0zBY4X0cH2qujRPc9LmFPWaTt3cZA/f1+u//ko9N5nyPUCbL3IqPIKYUfcNoY4VNGtmKyY4tpb1rqo+zqNe9ctgK7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=px2kYhVD; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="px2kYhVD"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-486fd27754bso17701775e9.3
        for <linux-block@vger.kernel.org>; Sat, 21 Mar 2026 01:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1774081367; x=1774686167; darn=vger.kernel.org;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6QapcZiZKmzc/L5G+0kT/84EOk/SJve3kRBM9k5Ue3U=;
        b=px2kYhVDtNswWLDa6o3fbegY8gJGwsxyDiXC5Wo0dHT58bbZMx2+vzgI8XZwC2ujg+
         W/vx477HqsUgELImhHHdpFy9lWE3mgGJRYI5JHnwU5LfwdshyPrrqJyVrVPh7AXF2dxq
         5M+5ZxE5N0CEIyD55NrImwjhHxW3kOgYzvArq+e+2XZxNX7yhy7Iaf2jDcd+fg/oEhSG
         borXKZ/nKL7qgcSTmMs49oW6xlxKAl4gn5Vu5+Xn0jTkCvtLJZpZpv3p9LL1BX0olOEe
         mWOUmxJqsXYWRho6VgPdiWh1VqzRdM/hnp7e/QMdlnlYmlw7uTVzMpT67sKqTocX08di
         PwFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774081367; x=1774686167;
        h=content-transfer-encoding:content-disposition:mime-version
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6QapcZiZKmzc/L5G+0kT/84EOk/SJve3kRBM9k5Ue3U=;
        b=oGB+ZQouqH5AIvxnN4/ZcUZvY298mgkuVqT9W48eGfKlPjIAsPog0+UcPKoYqFcKDe
         pY5St7HeB51R0gZsDPWC5tOrfZ/k78MHLHXJtiOjC5nsyZMhUvYMpwA08OLRab3YWRgg
         FHla5J2sIcLr91t0BMPXD6FhRqFSYqdKANewIjO6e/hbXU0miWV/2Ai+PiSf8Mt2w0Ck
         0sDt13HGnAn5IyKbMcWB+htOzZCQkOQr5Rt8IBNJsaNzgqtZGpM64PFCk6YoACn2XW/z
         xOSQN4dKMXeaQg42sXY542sbOyGGnbOjWoV+C8GEzJM2zyS64piZbq3TBR/0d6i7GOhX
         ofig==
X-Forwarded-Encrypted: i=1; AJvYcCUKQTM+Ol8Q/ZahyIxdb0vGV17HUVWNTIFkRfP8UdZCpdv2I2n4zvJkt51eTX4W2k8xdp/nCkMpshhVAQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YyEoWVGVuRyvxrvytnb7Cr9E5aX4sd+ePuRo216dmy042+1f40y
	xuExIqdxoIMpN+YVLGu3ALPf3Hkzc8zaSfwFdWG0E7zHDhZp81iWtP31KaiXf0eciLw=
X-Gm-Gg: ATEYQzw9ftunONApiBYgNiDgI7TooOnvzpclXxdADaPeH07M3OFT/RJb93I/IsAV7y8
	0q9lf9HMxqCnzPQQwb2N0VURXGsvVcJLQuHCvqWm5t3T8SiqU2wgTbeaIiXtejnwtED3jAk4tmD
	ALAdIbh0eGUQBAfwxeGXW1cG13d7VJ3tvRDyB5s58awm7GUiLXDeOmAuXloh/Gx7AtWC0pZA4XN
	w/3wp42k6sAb8bh7EldEw/POzW5BGH37k1inYCCpixBCwdA+8NltUlW8Zt4NVRBExFUP8attb6Z
	10eE5wb2A2j+QcdBAdNs2tAl9gxKDwVeO8fZAftwp7rDszmuiAR6fS029BVlJgFLsbmHqcUXXDq
	TXVhvbbykWiSX67e0nEO+6qQiKlF1O/VMIqITwO6PnDPR7rn907tcajAbYVFqxqEhsymqtPVDHM
	UCGl9eNO/EzZWL19q9UHtQRKRpr8pU
X-Received: by 2002:a05:600c:524e:b0:486:f634:ef3 with SMTP id 5b1f17b1804b1-486ff01efcdmr79549725e9.32.1774081366958;
        Sat, 21 Mar 2026 01:22:46 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48703e26408sm48164995e9.11.2026.03.21.01.22.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Mar 2026 01:22:46 -0700 (PDT)
Date: Sat, 21 Mar 2026 11:22:43 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: oe-kbuild@lists.linux.dev,
	Christoph =?iso-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Cc: lkp@intel.com, oe-kbuild-all@lists.linux.dev,
	linux-block@vger.kernel.org
Subject: [linux-next:master 6465/7971] drivers/block/drbd/drbd_debugfs.c:336
 drbd_get_peer_request_state() warn: bitwise AND condition is false here
Message-ID: <202603210529.IutAxKNP-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
head:   785f0eb2f85decbe7c1ef9ae922931f0194ffc2e
commit: 945807e66a140e5ee0f919d04e15eadd4cc294be [6465/7971] drbd: remove BROKEN for DRBD
config: nios2-randconfig-r073-20260321 (https://download.01.org/0day-ci/archive/20260321/202603210529.IutAxKNP-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 10.5.0
smatch: v0.5.0-9004-gb810ac53

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
| Closes: https://lore.kernel.org/r/202603210529.IutAxKNP-lkp@intel.com/

smatch warnings:
drivers/block/drbd/drbd_debugfs.c:336 drbd_get_peer_request_state() warn: bitwise AND condition is false here

vim +336 drivers/block/drbd/drbd_debugfs.c

0c897516a4856d Christoph Böhmwalder 2025-12-16  329  static enum drbd_peer_request_state drbd_get_peer_request_state(struct drbd_peer_request *peer_req)
f418815f7adad4 Lars Ellenberg       2014-05-05  330  {
0c897516a4856d Christoph Böhmwalder 2025-12-16  331  	unsigned long interval_flags = peer_req->i.flags;
0c897516a4856d Christoph Böhmwalder 2025-12-16  332  
0c897516a4856d Christoph Böhmwalder 2025-12-16  333  	if (interval_flags & INTERVAL_SUBMITTED)
0c897516a4856d Christoph Böhmwalder 2025-12-16  334  		return PRS_SUBMITTED;
0c897516a4856d Christoph Böhmwalder 2025-12-16  335  
0c897516a4856d Christoph Böhmwalder 2025-12-16 @336  	if (interval_flags & INTERVAL_SENT)

This should be if (interval_flags & BIT(INTERVAL_SENT)) or
test_bit(INTERVAL_SENT, &interval_flags).

0c897516a4856d Christoph Böhmwalder 2025-12-16  337  		return PRS_SENT;
0c897516a4856d Christoph Böhmwalder 2025-12-16  338  
0c897516a4856d Christoph Böhmwalder 2025-12-16  339  	return PRS_NEW;
0c897516a4856d Christoph Böhmwalder 2025-12-16  340  }

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

