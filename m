Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E20F21362
	for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 13:17:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718975876; cv=none; b=Ji4fdNAv94DCUpjgmhdZScJpIV/utTdO/EQRt9AY85jsiDiJ+GOLb9RLY8tXGpheMy+FO47ehbovUx2CkNMTUCw9NUMQimOStQElUuzwD11AyYlW6cmbHFYkweEG2Hdy3XXoIxcmA02ZYFqeqfhfzrk4Kqn7X3DWZUq+jsTDXO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718975876; c=relaxed/simple;
	bh=38Y6QscORe0bduh7rBvnxTrViboVZquyKxNCr8kG6sM=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=pZ11qbBMPTGT3cyKqQCOjqAoghibhm1XdweWLOQ18vYwCKjnwVghd311zHBngrbr5PVX+mNrBuxqos0Apaf39UwfGnq/cFMZnwKyzsodXlTKgW/vPNO0Rlfi61lKkqYD4pW0R6u4TXy9mRg6z0vrbrYC5DFr30Y0npnuk057z7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YIE4cRSc; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YIE4cRSc"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-63bb0ff142cso20268997b3.3
        for <linux-block@vger.kernel.org>; Fri, 21 Jun 2024 06:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718975873; x=1719580673; darn=vger.kernel.org;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yguMtkjkulh7/yWGXRWw1AHRKvgy+3uXZC9yUtgiuPQ=;
        b=YIE4cRSc8YHkPy83R97YkcNl+QT1RxVmsayR1eoLl9npMIh2IhvA+nbz5dGbL6+JUz
         n1zDiaPhvvvK14jJgB0r4ZPdi8y7zHBRncx75ANfLliRn/YKn/NNgD8b+eTnwTNu5B2a
         2ubL2tNiuNiHBABADgDi5euSYPhSsNTdOICt7bKKh9iOlCJWEB1JMkqkLB6JxXkz3PKx
         I/Sk5Udmh8fajqxDEmm8S8/T1UNwp6zp9tscLqXteORuRhl6C25HqifRR8p1Eog+q60B
         YIlY9mHjJEPHTgVHhMMgGWSpbDlcI2asc55EvzW2CzJ/Fu6fjLSh07E6dttBLQEKkKcz
         aPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718975873; x=1719580673;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yguMtkjkulh7/yWGXRWw1AHRKvgy+3uXZC9yUtgiuPQ=;
        b=V78+HINSfYAYNGjpQi3r/rEVyAP2xOMB2BoCB7ACVFb3caLBxiuUuSwezSQ0UfpsSo
         N9RrotnhNMoUGiSsXhPeuQ5/bq5X7aoI7COlNW/k6tBdrEyfibEilC++9juP2q3BN1sy
         eX7W06GT0kAT8/eB6gwPnEyebvEm8XafIuN2e96f8B20oPcOODV7tQ3pOwHEXzDCtIyM
         eTG9qxLl1+a2/a7y5fLykhYMcdcJ+NHJgRvgcRL13b7+RR7co7kJe2zGrbgiettdITXx
         /YJGvjs+CgHOq4BPDw19oldmnXtiG5hfVrnCp6CqWYbyk5rGmgsPlTlS0moQI9uoq6VX
         6npw==
X-Gm-Message-State: AOJu0YwgK+Y831QyBo5VNZm3tBnlhBtntulzrX+5DF3wRemtUP3QoWMH
	cVmz7463i/XUO7zsEnbXIPl3nHO8bvCcnaVFcofSpCIB1YhxywE8OwL/1ONo
X-Google-Smtp-Source: AGHT+IHjxUnN5vQ6theaBa/uNSxtmggnHbBNjMfM7OwotDMl9To/OC7+qgtlvbkgwsWClgKvGFeByA==
X-Received: by 2002:a81:8408:0:b0:63b:aefc:84c1 with SMTP id 00721157ae682-63baefc8523mr69103507b3.12.1718975873524;
        Fri, 21 Jun 2024 06:17:53 -0700 (PDT)
Received: from [127.0.0.1] (23-114-102-58.lightspeed.sntcca.sbcglobal.net. [23.114.102.58])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-63f14a3cd92sm3332437b3.102.2024.06.21.06.17.52
        for <linux-block@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jun 2024 06:17:53 -0700 (PDT)
Message-ID: <8bb45399-de8e-4f2f-afd1-d1098dcdc9d0@gmail.com>
Date: Fri, 21 Jun 2024 21:17:32 +0800
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: linux-block@vger.kernel.org
From: sxzzsf <sxzzsf@gmail.com>
Subject: sg's SG_DXFER_TO_FROM_DEV failed to work after kerne 6.1.80
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

The change of block/blk-map.c in kernel 6.1.80:

static int bio_copy_user_iov()
{
         ......
         } else if (map_data && map_data->from_user) {
                 struct iov_iter iter2 = *iter;
                 
                 /* This is the copy-in part of SG_DXFER_TO_FROM_DEV. */
                 iter2.data_source = ITER_SOURCE;
                 ret = bio_copy_from_iter(bio, &iter2);
                 if (ret)
                         goto cleanup;
         } else {
         ......
}

But it forget to update the iter's count and failed to exit the loop after bio_copy_user_iov() and re-copy to the bio in function blk_rq_map_user_iov():

int blk_rq_map_user_iov()
{
         ......
         do {
                 if (copy)
                         ret = bio_copy_user_iov(rq, map_data, &i, gfp_mask);
                 else
                         ret = bio_map_user_iov(rq, &i, gfp_mask);
                 if (ret)
                         goto unmap_rq;
                 if (!bio)
                         bio = rq->bio;
         } while (iov_iter_count(&i)); /* <-- ALWAYS FALSE HERE */
         ......
}

In order to complete the iov map, the iter's count should be updated to iter2'count after bio_copy_from_iter():

--- block/blk-map.c.orig        2024-06-21 08:42:35.662927873 -0400
+++ block/blk-map.c     2024-06-21 08:42:42.450776813 -0400
@@ -218,6 +218,7 @@ static int bio_copy_user_iov(struct requ
                 ret = bio_copy_from_iter(bio, &iter2);
                 if (ret)
                         goto cleanup;
+               iov_iter_truncate(iter, iov_iter_count(&iter2));
         } else {
                 if (bmd->is_our_pages)
                         zero_fill_bio(bio);

or following patch, save iter's data_source before copying, restore iter's data_source later:

--- block/blk-map.c.orig        2024-06-21 08:42:35.662927873 -0400
+++ block/blk-map.c     2024-06-21 09:05:47.423032619 -0400
@@ -211,11 +211,12 @@
                 if (ret)
                         goto cleanup;
         } else if (map_data && map_data->from_user) {
-               struct iov_iter iter2 = *iter;
+               bool data_source = iter->data_source;
  
                 /* This is the copy-in part of SG_DXFER_TO_FROM_DEV. */
-               iter2.data_source = ITER_SOURCE;
-               ret = bio_copy_from_iter(bio, &iter2);
+               iter->data_source = ITER_SOURCE;
+               ret = bio_copy_from_iter(bio, iter);
+               iter->data_source = data_source;
                 if (ret)
                         goto cleanup;
         } else {

Verified by (modify lib/sg_pt_linux.c to ignore the bidi limitation):

./src/sg_raw --infile=dat.bin --send=96 --request=96 --outfile=out.bin /dev/sg0 12 00 00 00 64 00

Before patching, it failed as -EINVALID.
After patching, it works as expected.
