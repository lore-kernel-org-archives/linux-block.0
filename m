Received: from mail-qt1-f227.google.com (mail-qt1-f227.google.com [209.85.160.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F73A847B
	for <linux-block@vger.kernel.org>; Fri,  4 Apr 2025 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743728982; cv=none; b=BvTF7BV5M9wSckEfxB2K4S6JHir6zSdLuMzF8ApmOYncxXnqKACqvp5dHJ1R0guomWh+VHbBQtc9nWZjN63Rv7aLQJqCVxbxIZqPhHBmsi3qK8SmugcKlJ4kRTYNGluvrvntgdQYiB7a/UWkAyocRkY+5o+VojepBz0usc1ZYAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743728982; c=relaxed/simple;
	bh=29lT6XM9PTfZ4QzSmdqHkLSRtATT0hhp6i8w7wwJdS4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eINODwAhQFXEg1rfPIhXRwT+iUWhg32eosuv0qu7bU/Abm19aLb5U8IJtsEirj4W+25Fx7uhmS1E8JK9Ja7VHFgJ1pJePhTjhjDJTOsGOES2jcofYNa7DaUO8P2xRtsl/8lrRBjplm0vvc0vXwcuZtj+GFLgrUa+Bm78UKAqS/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=fail smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=Ok53p5cU; arc=none smtp.client-ip=209.85.160.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="Ok53p5cU"
Received: by mail-qt1-f227.google.com with SMTP id d75a77b69052e-4774ce422easo15840631cf.1
        for <linux-block@vger.kernel.org>; Thu, 03 Apr 2025 18:09:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1743728979; x=1744333779; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=jwQEWgYNpeA/XdQZYs4KZSISRZNjHiSXarPqse8C4Lo=;
        b=Ok53p5cUkWo8cU1moT01qVu8snJJ5mjp7gly+uVYK652Gz4hj3XzaY8EaOS4soXNBd
         tFJle0JsSh1Fgc6bUhz3ngWUBhhaorvdnfzI6RDWQ0ldxFPmdUpssxGuxoO7ChvmIfae
         8/lCexvd+fkJoS+8bp8kWvIeTytSSNXqTA271rvZPAlqeUj5DfmxolMRz1RhjRxpqGI+
         w5ewCGsPn7BztHyYcbxTFBXiSWMqw4If76evALuzMQk9uxg7lMVOKN5aPMCct+aHXb7O
         1siKM84Xy6a+FzXKE7zqohp/Z5pjMmQroY4auhQHmGspipLML1urj9iyf0LV2wg2Jq0i
         yLaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743728979; x=1744333779;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jwQEWgYNpeA/XdQZYs4KZSISRZNjHiSXarPqse8C4Lo=;
        b=uqXzujT2NGaFVyQ5kcOqmbNhfNoCU5ogr3e+5hYcRRo8Nk0JPo0XRNnPH10Su8+7HJ
         Rioc95CSEoCslDRveUOkyOkpcwKtAE32qNpu5P5vqyzaHZYsIQIEuiXxI6elp2LTVJ1o
         F48e73JqnaBpUOxUd78cr04O9FLP9daxeNCeyIGYg0TKjLjF1yqnLR3N3w2ovSvlseZt
         fl8F17/VhO+8OEtPoVKHdgANE98c3z9r3beMpooFN4WxIb/Yzxi+WhekB3wzqqPatZHY
         Odt5Rd/Gr5jAA2iwnJL53WwtEqUF812KGCajv7/B7HWaExNq+et3c5Q5d52V8uY1SWF/
         O8eQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6MiItNaIesAkwUSiRBGvklpzJc/2l7IaDWtDz98znugBnhZpGGvo3zVZX7U/6MA9Ur8RfHDnhKxdnXw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxws9XNhwrvlheIuUIsACIVBk3s1Xno+7pPuv9s1tXJVPBAw8XR
	jHA5IpJV5Yx4IeHAa/hUGU8KH5tL9iYs+peayVmr5oYOmMblofs3+uQJHZXsLXW2Y2pPyKYONr5
	UEBa3XpEO4kAQfcpBy00vUGlR3UNEwz2cB+6vdV2bjyRrVSfW
X-Gm-Gg: ASbGnctVjB9xLZFPrvNIctFdMxvnl/my8BHb7noDXMgmyJ2TCVA89pCA48RPojGRhY9
	+/LqpvLlukk88Csb5uXaDhNkgDWonXwY+pA+stNK0Q4qOehE9oujDf2iFZeTQfuuLABXbXLBC/9
	2pJrcyL7gUzLZGT4VyHDOQDaMKRwAR/XB9TLl68DPeaSBMsKvmnwM7Fpzws6WyYuxSynKpNj3ql
	N1UMG1sRUAiZjPXgS7UynEvXAsWWmt3mDF58WS4N5I7o71aaNN2/Ui18zShe2yqsfi5Er3z8w/+
	yB6CmXxBgvdgYD8Iiw7tozg0QYDXeID1J9s=
X-Google-Smtp-Source: AGHT+IFbaP0mwBaR8q8i3zD2ZnPyJe0r1qMugaz1L2sPKth/VzHKfAqr2DbO/d4t7VG2fNT5giS7BAelJDKT
X-Received: by 2002:a05:6214:409:b0:6e8:f3c3:9809 with SMTP id 6a1803df08f44-6f01e7268d0mr26670476d6.20.1743728978718;
        Thu, 03 Apr 2025 18:09:38 -0700 (PDT)
Received: from c7-smtp-2023.dev.purestorage.com ([2620:125:9017:12:36:3:5:0])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-6ef0f00ec55sm4209416d6.17.2025.04.03.18.09.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Apr 2025 18:09:38 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-ushankar.dev.purestorage.com (dev-ushankar.dev.purestorage.com [10.7.70.36])
	by c7-smtp-2023.dev.purestorage.com (Postfix) with ESMTP id 844D6340166;
	Thu,  3 Apr 2025 19:09:37 -0600 (MDT)
Received: by dev-ushankar.dev.purestorage.com (Postfix, from userid 1557716368)
	id 791DFE40506; Thu,  3 Apr 2025 19:09:37 -0600 (MDT)
Date: Thu, 3 Apr 2025 19:09:37 -0600
From: Uday Shankar <ushankar@purestorage.com>
To: Ming Lei <ming.lei@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, io-uring@vger.kernel.org,
	linux-block@vger.kernel.org,
	Pavel Begunkov <asml.silence@gmail.com>,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: Re: [PATCH] selftests: ublk: fix test_stripe_04
Message-ID: <Z+8xUR/Ocbmorisk@dev-ushankar.dev.purestorage.com>
References: <20250404001849.1443064-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250404001849.1443064-1-ming.lei@redhat.com>

On Fri, Apr 04, 2025 at 08:18:49AM +0800, Ming Lei wrote:
> Commit 57ed58c13256 ("selftests: ublk: enable zero copy for stripe target")
> added test entry of test_stripe_04, but forgot to add the test script.
> 
> So fix the test by adding the script file.
> 
> Reported-by: Uday Shankar <ushankar@purestorage.com>
> Signed-off-by: Ming Lei <ming.lei@redhat.com>

Reviewed-by: Uday Shankar <ushankar@purestorage.com>

Thanks for the quick fix!

> ---
>  .../testing/selftests/ublk/test_stripe_04.sh  | 24 +++++++++++++++++++
>  1 file changed, 24 insertions(+)
>  create mode 100755 tools/testing/selftests/ublk/test_stripe_04.sh
> 
> diff --git a/tools/testing/selftests/ublk/test_stripe_04.sh b/tools/testing/selftests/ublk/test_stripe_04.sh
> new file mode 100755
> index 000000000000..1f2b642381d1
> --- /dev/null
> +++ b/tools/testing/selftests/ublk/test_stripe_04.sh
> @@ -0,0 +1,24 @@
> +#!/bin/bash
> +# SPDX-License-Identifier: GPL-2.0
> +
> +. "$(cd "$(dirname "$0")" && pwd)"/test_common.sh
> +
> +TID="stripe_04"
> +ERR_CODE=0
> +
> +_prep_test "stripe" "mkfs & mount & umount on zero copy"
> +
> +backfile_0=$(_create_backfile 256M)
> +backfile_1=$(_create_backfile 256M)
> +dev_id=$(_add_ublk_dev -t stripe -z -q 2 "$backfile_0" "$backfile_1")
> +_check_add_dev $TID $? "$backfile_0" "$backfile_1"
> +
> +_mkfs_mount_test /dev/ublkb"${dev_id}"
> +ERR_CODE=$?
> +
> +_cleanup_test "stripe"
> +
> +_remove_backfile "$backfile_0"
> +_remove_backfile "$backfile_1"
> +
> +_show_result $TID $ERR_CODE
> -- 
> 2.47.1
> 
