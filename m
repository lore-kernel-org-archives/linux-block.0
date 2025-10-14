Received: from 004.mia.mailroute.net (004.mia.mailroute.net [199.89.3.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9402DE202
	for <linux-block@vger.kernel.org>; Tue, 14 Oct 2025 21:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=199.89.3.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760476889; cv=none; b=BB4WMUPfNYKY/IlDdYMQiOEzNXArqMrvUoccPpA0mPAZFo1lwm8x//Uf1asr5cjZuQ3tNbOJVnMLFVq2Uqh0/IjA+ea65+V0SsMhB1h527QfCqWBnVH6ggmYTVRbDkBV2D8s9kfeumXgTdC+hNoKAIBmdAFxDC2MAJTGfCANIaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760476889; c=relaxed/simple;
	bh=ul/nZlOXjvtDrpRrrNptL9PDExuRxgUu4sIchHpnq28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X1orxk97ibvlwdzfPd9OjpuyJGDMezo3+7MVn9+xvPhwiStp/sRIlgV3A9Z/wWpqhSq5ChinRjYmzd6SMP/eYDDhyoSNDwHrvxZgF8Pki2Nde/TX40qjFXnRONqv7kfBswzal+IjjcqqkZJ3PxNbJeplzMBH+U3KpbKoRlGucmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org; spf=pass smtp.mailfrom=acm.org; dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b=Ucp4Uvwu; arc=none smtp.client-ip=199.89.3.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=acm.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=acm.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=acm.org header.i=@acm.org header.b="Ucp4Uvwu"
Received: from localhost (localhost [127.0.0.1])
	by 004.mia.mailroute.net (Postfix) with ESMTP id 4cmRwj62J3zm0yVD;
	Tue, 14 Oct 2025 21:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=acm.org; h=
	content-transfer-encoding:content-type:content-type:in-reply-to
	:from:from:content-language:references:subject:subject
	:user-agent:mime-version:date:date:message-id:received:received;
	 s=mr01; t=1760476884; x=1763068885; bh=ZcD0ugubhgbWRQRMTnwrhTf/
	G7MPeIlA0QZYu8KtsbI=; b=Ucp4Uvwu+XTu1k8+JE+RwDogKYdsF+z0BiJOz6nB
	mU/sJvHx318LJCIIzb/7GOoYwLE9Mz+LLolNdywNKhvGoufCnF7pzYW1HRdU7TSP
	C63wYjuBxp/G71byAEmZC2WxwKon/KY9ssmcVlfz0QFhaq3RMBmZY9sv8ZbYfDFd
	xJo0LZIWfvvJZEHviMmvWwl3H8Hatqd7bKTpggN5VPo/O1nsMsx9RihJ85P/yq7b
	IVQc8h/T3OIFBgDyXvWY1ymsXooF5MGQBJ5KnibLIML+ehpR13XZVi9TkBb9ZOq/
	y8L1sxH18CsVwyPvpuFSvtIzgzb11PcqJOtjFlJBz88+fg==
X-Virus-Scanned: by MailRoute
Received: from 004.mia.mailroute.net ([127.0.0.1])
 by localhost (004.mia [127.0.0.1]) (mroute_mailscanner, port 10029) with LMTP
 id rEMY7kBHgIOo; Tue, 14 Oct 2025 21:21:24 +0000 (UTC)
Received: from [100.119.48.131] (unknown [104.135.180.219])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bvanassche@acm.org)
	by 004.mia.mailroute.net (Postfix) with ESMTPSA id 4cmRwf2j0Tzm0ySn;
	Tue, 14 Oct 2025 21:21:21 +0000 (UTC)
Message-ID: <ac0c15bb-7679-490a-93aa-ffdc7635ec3f@acm.org>
Date: Tue, 14 Oct 2025 14:21:20 -0700
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH blktests] create a test for direct io offsets
To: Keith Busch <kbusch@meta.com>, linux-block@vger.kernel.org,
 shinichiro.kawasaki@wdc.com
Cc: Keith Busch <kbusch@kernel.org>
References: <20251014205420.941424-1-kbusch@meta.com>
Content-Language: en-US
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20251014205420.941424-1-kbusch@meta.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/14/25 1:54 PM, Keith Busch wrote:
> +static void find_mount_point(const char *filepath, char *mount_point,
> +			     size_t mp_len)
> +{
> +	char path[PATH_MAX - 1], abs_path[PATH_MAX], *pos;
> +	struct stat file_stat, mp_stat, parent_stat;

Why C instead of C++? Any code that manipulates strings is usually
significantly easier to write in C++ rather than C.

> +	strncpy(mount_point, path, mp_len - 1);
> +	mount_point[mp_len - 1] = '\0';

Why strncpy() instead of strdup()?

> +	len = strlen(base);
> +	p = base + len - 1;
> +	while (p > base && *p >= '0' && *p <= '9')
> +		p--;
> +
> +	if (p > base && *p == 'p' && *(p + 1) != '\0')
> +		*p = '\0';
> +	else if (len >= 4 && p > base && p < base + len - 1) {
> +		if ((strncmp(base, "sd", 2) == 0 ||
> +		     strncmp(base, "hd", 2) == 0 ||
> +		     strncmp(base, "vd", 2) == 0) &&
> +		     (*p >= 'a' && *p <= 'z'))
> +			*(p + 1) = '\0';
> +	}

Deriving the disk name from a partition name by stripping a suffix is 
fragile. A better way is to iterate over /sys/class/block/*/*. See also
the PartitionParent() function in 
https://cs.android.com/android/platform/superproject/main/+/main:system/core/fs_mgr/blockdev.cpp.

> +static void read_sysfs_attr(char *path, unsigned long *value)
> +{
> +	FILE *f;
> +	int ret;
> +
> +	f = fopen(path, "r");
> +	if (!f)
> +		err(ENOENT, "%s", path);
> +
> +	ret = fscanf(f, "%lu", value);
> +	fclose(f);
> +	if (ret != 1)
> +		err(ENOENT, "%s", basename(path));
> +}

Why is the result stored in a pointer argument instead of returning it
as return value?

> +static void read_queue_attrs(const char *path)
> +{
> +	char attr[PATH_MAX];
> +
> +	if (snprintf(attr, sizeof(attr), "%s/max_segments", path) < 0)
> +		err(errno, "max_segments");
> +	read_sysfs_attr(attr, &max_segments);

Has it been considered to make read_sysfs_attr() accept a format string
+ arguments? I think that would make the code in this function more
compact.

Thanks,

Bart.
