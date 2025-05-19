Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F3DD13AA20
	for <linux-block@vger.kernel.org>; Mon, 19 May 2025 02:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747622717; cv=none; b=bA4XlkEWx19MM1HNnAVrN0oMAd5JxfWvyuxutEB/OdemrwGKTzesOG208S+HSV3onty5e07k4RoAxcHoh5aD/KoscLyL4GzM02z0dCquG7W0fPWfGjh64GZY3EzNbLC4mRq9QZb3j1ZTsPtE7gbqYnRy+dM2cdmxF/ByIqC8/ZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747622717; c=relaxed/simple;
	bh=WF/hScSqMYZKjb09xLRFphZW8bb741gihM/G7WwNjOc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KjiWtPzu2SJCRkdbumTrNiOgCjFc9sa2QRx9v0TDb6PskPDJzmA5dY6byUKOUzyBdgM7AUqJ96kkdAIKq6YSmu+RIzW0yJEiiXx6oudxr9GAdsNdAsHMtT5mzXJxeUvTBG8n0wgXh4jb/GPJecatHl0fFsenkHVAQmhuiduduio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j1zgV2Fy; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j1zgV2Fy"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2322dc5c989so4229655ad.3
        for <linux-block@vger.kernel.org>; Sun, 18 May 2025 19:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747622715; x=1748227515; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rHdkBFB5XETbfJ5yRiQadK5eC0qqF5lm87QpRireY70=;
        b=j1zgV2FyfqJyyYGvIZAFpOCFja74mL/SGoKN38/MkhTkNudsSiO6dFpuRivRpGup3n
         6ZuQ4OY/HEy0D40/Y6fQcK4CczZIBHKzeEq1xj4mex90HE8d4C/6BlTTj8NzYFmZEIZM
         25sWsbSt+DxgewWFywnmFtDvidLAVXzO/yw0izFrIIxzG3mRcqoEzzOhIVx5TH7jdn8l
         QSEwrxG3SzFdgSrVuO4uzz8hv1GpJwottC4R1LJh+mv8fOoUg/bWG9r7V4SfLZihNo+n
         ASEXF2/obY9/QZbBW192e0Gyyi9QunEda2gml7NsZVugJdUQw3q76VscbjBdOWmUmelY
         rQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747622715; x=1748227515;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rHdkBFB5XETbfJ5yRiQadK5eC0qqF5lm87QpRireY70=;
        b=udi1JZZR/KeVa5t+yj2XuG7nip4tnMt6MpniXLdUeYwWJ/yWBVNRZ6c3L/+6dVQccx
         YOoj6MWthSMTXALYIQr35fA1NElK6W7QYO8uj4GUR1RD6gEBu1gacDnM5x16rUWA3JqP
         833zWunCduCH0aCLEULYYYQG6xGQakCWRmFh2tlgNQT5EIOK9LH6W2bPZe7y4InXB4hk
         hMcIoeTP8FOoa8FTfNc2R+8xH9lWRqg6QU53Y3t+BREpx59gcEU8/QdenPEP/7TuZG64
         IIYqlc/Ol+JFjy/KX2RBkHAq8cf7wjNEnlWMv8JS2RkYQVflPSAWFb6J5u2OwhlhBQw5
         raLw==
X-Forwarded-Encrypted: i=1; AJvYcCW9p9DdPiXN9dWqL3xb0sfpSrVBc7IhqPgZ54D+FItnc7s69FK/ryp8KeDuBdy0U3wl3OEitskUj13mFA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzYVmF2kYRgsmyDgsZIKyfqEHokjbpvSFNIWSbI5acdtlf3299E
	n/MFYJqHvmhrBbjWvRQefsbvFYjFbJy31fE1sXfUT8yqRxJ+kn9xpsb9
X-Gm-Gg: ASbGnctfi/vXUwANrDDJXPsXizFz59OcGJMDiaaPeKyYap2cGfZllFthlI+A1qfuWLo
	VWQfJ5kebHVqW2BDO4qAYOLyAPLdouSIw2HWD/GZjvWq79/pkiSxUDZKT+F4pD3kElt3xvepSEs
	plgDGgGpwKmwvOvDhJht+PiSztuQlLHuJhifOoEgA/ITEeudszBZPuAygeHW00E+6OR8iaNVzjL
	o1WH9GvK3jqJgv+BVd+U09rPnnph4ZzkHe3glcHee9sFwXKB+aPkjHKMiPJAuludgGZCzdO3I6Q
	S8cbtClCic82Nc2ghWiFj1Gpn4cM6Yw0Oc1xlUz9h1TMxmNKdxv1lYdcPyoIHZpu+DHJrdLADfE
	52ruc5GOy2oTcjrUwJljkS/rv8g==
X-Google-Smtp-Source: AGHT+IFx0ivHSxG7Uv4/6buMfmzgApuK8gwWV7DUwEQO4XyO2zkO1mltohtvtZ7bCUBqKs3UQIdd8g==
X-Received: by 2002:a17:903:1246:b0:224:26f2:97d6 with SMTP id d9443c01a7336-231de3427cfmr164812315ad.28.1747622715213;
        Sun, 18 May 2025 19:45:15 -0700 (PDT)
Received: from 172-126-48-156.lightspeed.nsvltn.sbcglobal.net ([2001:250:3c1e:503:ffff:ffff:d4aa:4903])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-231d4e97dadsm49631975ad.141.2025.05.18.19.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 May 2025 19:45:14 -0700 (PDT)
Date: Mon, 19 May 2025 10:45:08 +0800
From: Ming Lei <tom.leiming@gmail.com>
To: Jared Holzman <jholzman@nvidia.com>
Cc: Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Ming Lei <ming.lei@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Uday Shankar <ushankar@purestorage.com>,
	Caleb Sander Mateos <csander@purestorage.com>,
	Guy Eisenberg <geisenberg@nvidia.com>, Yoav Cohen <yoav@nvidia.com>,
	Omri Levi <omril@nvidia.com>, Ofer Oshri <ofer@nvidia.com>
Subject: Re: [PATCH V2 2/2] ublk: fix race between
 io_uring_cmd_complete_in_task and ublk_cancel_cmd
Message-ID: <aCqbNNjRs3D6jejz@172-126-48-156.lightspeed.nsvltn.sbcglobal.net>
References: <20250425013742.1079549-1-ming.lei@redhat.com>
 <20250425013742.1079549-3-ming.lei@redhat.com>
 <mruqwpf4tqenkbtgezv5oxwq7ngyq24jzeyqy4ixzvivatbbxv@4oh2wzz4e6qn>
 <4395080b-7628-4290-9edd-ba442f0e096b@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4395080b-7628-4290-9edd-ba442f0e096b@nvidia.com>

On Sun, May 18, 2025 at 10:12:29PM +0300, Jared Holzman wrote:
> On 14/05/2025 4:50, Shinichiro Kawasaki wrote:

...

> 
> Hi Shinichiro,
> 
> Are you referring to test_generic_02.sh in tools/testing/selftests/ublk?
> 
> I tried running it 20 times and it didn't get stuck

It is supposed to be triggered in stress_02.sh, but turns out it isn't
stressful enough, and the hang can be duplicated with the following change:

- single queue

- random IO

- --numjobs="$(nproc)"

diff --git a/tools/testing/selftests/ublk/test_common.sh b/tools/testing/selftests/ublk/test_common.sh
index a81210ca3e99..c17fd66b73ac 100755
--- a/tools/testing/selftests/ublk/test_common.sh
+++ b/tools/testing/selftests/ublk/test_common.sh
@@ -251,7 +251,7 @@ __run_io_and_remove()
        local kill_server=$3

        fio --name=job1 --filename=/dev/ublkb"${dev_id}" --ioengine=libaio \
-               --rw=readwrite --iodepth=256 --size="${size}" --numjobs=4 \
+               --rw=randrw --norandommap --iodepth=256 --size="${size}" --numjobs="$(nproc)" \
                --runtime=20 --time_based > /dev/null 2>&1 &
        sleep 2
        if [ "${kill_server}" = "yes" ]; then
diff --git a/tools/testing/selftests/ublk/test_stress_02.sh b/tools/testing/selftests/ublk/test_stress_02.sh
index 1a9065125ae1..e532ca6bd569 100755
--- a/tools/testing/selftests/ublk/test_stress_02.sh
+++ b/tools/testing/selftests/ublk/test_stress_02.sh
@@ -30,5 +30,7 @@ ublk_io_and_kill_daemon 256M -t loop -q 4 "${UBLK_BACKFILES[0]}" &
 ublk_io_and_kill_daemon 256M -t stripe -q 4 "${UBLK_BACKFILES[1]}" "${UBLK_BACKFILES[2]}" &
 wait

+ublk_io_and_kill_daemon 8G -t null -q 1
+
 _cleanup_test "stress"
 _show_result $TID $ERR_CODE



Thanks,
Ming
