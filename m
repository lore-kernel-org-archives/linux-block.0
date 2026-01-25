Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A33E1E0E14;
	Sun, 25 Jan 2026 18:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769366141; cv=none; b=n0eD9l3xypbATOkRV/0fTOm11ImKsWxYDpZCmPiireK5xbo06Owo8TpIQjkNlSXgRE+gR3eQ4u613tU294jAiPAxyLcjNrjdiuEECtPZQpBA1odL2UEE2EWP5QUx7eME0Z1mBHxakW2004SFf9uneiA82zIm+L2tgC1s3SyBL54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769366141; c=relaxed/simple;
	bh=/+JWKCl/rMmMylcDCp60yI7tIO/uuQl3FBnTc6hQyng=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Uf7xAxyAPbFfMMc+K5C9kYkGQkUHwm1GmTnm2H9pL6Mzsi9haQ3dqedX+/HN8P94edtOWdJWV/J05NB/KNv9JfeVsOTApBlUW1gDRAbJdSYR4DXmYg3ka6WQatMLGjCs6RiXRJy9XNJyCBaUGB61pAHZ/n/wKBEWmJzEqeHe18E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=pbcR0W9o; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="pbcR0W9o"
X-Virus-Scanned: Yes
Message-ID: <c517e1ca-0e2b-4143-b0f6-07a3d0c3abcf@zazolabs.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1769366136; bh=/+JWKCl/rMmMylcDCp60yI7tIO/uuQl3FBnTc6hQyng=;
	h=Reply-To:Subject:To:Cc:References:From:In-Reply-To;
	b=pbcR0W9oOnzO9d8lZZDDfDRngN+hxGPh9cgG7kEnWsJoUvVINyEt1xBheaKJBKCNh
	 /yMfAKsODMUgq17C05SsX6Gp5GWua1jzD3YQREHA7KlX2BGlEYjBCXO42YnM0UZikG
	 r26Hwa7wyGldIGYqyDZYy647Il5Ty72ghzCJ86NlbZfPnqNXcFkeJOC4F2e9zpLnZx
	 9Rua9Lx4hNNMaebBTiSHsh2Uhn0bl1PYDOZ5QB9YYK9in5E1Cx4kSMVAPsbeW/F0hm
	 hRrtI/JWjDMh4r7Q9WNiYn5BURpt3LiENwD1Eq+YpzxTYcaJl5clFfbNlCX1VCtS3D
	 QQEFikF2MxGyUNvFiVY/0J3ZnhR+DZjkuy0Ih4DqNkVDevqaoaNIgtGtdU87InWeO5
	 xNIUbZdBjIp/tskKnUBWnqhf30m51P+wEk+Li9XROJbd6EEespVjwddc659cSyiF86
	 XYDPCygiVJBA81NDj63GSThN6muF+6XIE6fVjqj/7aaRm6/yaBGd5bH5ZXHcItJqty
	 Cmqp9c9HA22tcqAJS8Wejeg4KL7WRXBNIZqhr6NAmlOwU0luO2EtN8/UnBlaV9CXHS
	 pwi6OUWwMPMNz+4LJpXvnBeeAixH5uYlivZKMbS6RtIkPEIbZg7dOM2E0fJ2qhAOQB
	 ignyJKZ1762fhyjnYnm4+7mo=
Date: Sun, 25 Jan 2026 20:35:20 +0200
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Reply-To: alex+zkern@zazolabs.com
Subject: Re: [PATCH] selftests: ublk: io-reorder triggered in
 test_generic_01.sh
To: Ming Lei <ming.lei@redhat.com>
Cc: Shuah Khan <shuah@kernel.org>, linux-block@vger.kernel.org,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260123112039.1370223-1-alex@zazolabs.com>
 <aXN4mFuoXhtJDKyF@fedora> <147635F1-943E-46D5-8EF1-D1C965F85EC1@zazolabs.com>
 <aXOGrXo3AbXPHA-K@fedora> <03C8F5B9-B2E1-4C78-A043-B4F9422508B7@zazolabs.com>
 <aXY2qdYtfVTSc7jB@fedora>
Content-Language: en-GB
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <aXY2qdYtfVTSc7jB@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 25.01.26 17:28, Ming Lei wrote:
> On Fri, Jan 23, 2026 at 05:00:33PM +0200, Alexander Atanasov wrote:
>>
>>

[snip]

> Can you test the following patch and see if re-order still can happen?
> 
> 
> diff --git a/tools/testing/selftests/ublk/test_generic_01.sh b/tools/testing/selftests/ublk/test_generic_01.sh
> index 26cf3c7ceeb5..26d5e52ece29 100755
> --- a/tools/testing/selftests/ublk/test_generic_01.sh
> +++ b/tools/testing/selftests/ublk/test_generic_01.sh
> @@ -13,7 +13,7 @@ if ! _have_program fio; then
>   	exit "$UBLK_SKIP_CODE"
>   fi
>   
> -_prep_test "null" "sequential io order"
> +_prep_test "null" "ublk dispatch won't reorder IO"
>   
>   dev_id=$(_add_ublk_dev -t null)
>   _check_add_dev $TID $?
> @@ -39,9 +39,13 @@ fio --name=write_seq \
>   ERR_CODE=$?
>   kill "$btrace_pid"
>   wait
> -if grep -q "io_out_of_order" "$UBLK_TMP"; then
> -	cat "$UBLK_TMP"
> +
> +# Check for out-of-order completions detected by bpftrace
> +if grep -q "^out_of_order:" "$UBLK_TMP"; then
> +	echo "I/O reordering detected:"
> +	grep "^out_of_order:" "$UBLK_TMP"
>   	ERR_CODE=255
>   fi
> +
>   _cleanup_test "null"
>   _show_result $TID $ERR_CODE
> diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt b/tools/testing/selftests/ublk/trace/seq_io.bt
> index b2f60a92b118..60ac40e66606 100644
> --- a/tools/testing/selftests/ublk/trace/seq_io.bt
> +++ b/tools/testing/selftests/ublk/trace/seq_io.bt
> @@ -2,23 +2,45 @@
>   	$1: 	dev_t
>   	$2: 	RWBS
>   	$3:     strlen($2)
> +
> +	Track request order between block_io_start and block_rq_complete.
> +	For each request, record its start sequence number and verify
> +	completions happen in the same order.
>   */
> +
>   BEGIN {
> -	@last_rw[$1, str($2)] = (uint64)0;
> +	@start_seq = (uint64)0;
> +	@complete_seq = (uint64)0;
> +	@out_of_order = (uint64)0;
> +}
> +
> +tracepoint:block:block_io_start
> +{
> +	if ((int64)args.dev == $1 && !strncmp(args.rwbs, str($2), $3)) {
> +		@start_order[args.sector] = @start_seq;
> +		@start_seq = @start_seq + 1;
> +	}
>   }
> +
>   tracepoint:block:block_rq_complete
>   {
> -	$dev = $1;
>   	if ((int64)args.dev == $1 && !strncmp(args.rwbs, str($2), $3)) {
> -		$last = @last_rw[$dev, str($2)];
> -		if ((uint64)args.sector != $last) {
> -			printf("io_out_of_order: exp %llu actual %llu\n",
> -				args.sector, $last);
> +		$expected_order = @start_order[args.sector];
> +		if ($expected_order != @complete_seq) {
> +			printf("out_of_order: sector %llu started at seq %llu but completed at seq %llu\n",
> +				args.sector, $expected_order, @complete_seq);
> +			@out_of_order = @out_of_order + 1;
>   		}
> -		@last_rw[$dev, str($2)] = (args.sector + args.nr_sector);
> +		delete(@start_order[args.sector]);
> +		@complete_seq = @complete_seq + 1;
>   	}
>   }
>   
>   END {
> -	clear(@last_rw);
> +	printf("total_start: %llu total_complete: %llu out_of_order: %llu\n",
> +		@start_seq, @complete_seq, @out_of_order);
> +	clear(@start_order);
> +	clear(@start_seq);
> +	clear(@complete_seq);
> +	clear(@out_of_order);
>   }


First run after reboot always fails:

./test_generic_01.sh
ublk selftest: generic_01 starting at 2026-01-25T19:08:47+02:00
I/O reordering detected:
out_of_order: sector 112040 started at seq 88 but completed at seq 0
out_of_order: sector 112048 started at seq 89 but completed at seq 1
out_of_order: sector 112056 started at seq 90 but completed at seq 2
out_of_order: sector 112064 started at seq 91 but completed at seq 3
out_of_order: sector 112072 started at seq 92 but completed at seq 4
out_of_order: sector 112080 started at seq 93 but completed at seq 5
out_of_order: sector 112088 started at seq 94 but completed at seq 6
out_of_order: sector 112096 started at seq 95 but completed at seq 7
out_of_order: sector 112104 started at seq 96 but completed at seq 8
out_of_order: sector 112112 started at seq 97 but completed at seq 9
out_of_order: sector 112120 started at seq 98 but completed at seq 10
out_of_order: sector 112128 started at seq 99 but completed at seq 11

[snip]

out_of_order: sector 1048528 started at seq 117149 but completed at seq 
117061
out_of_order: sector 1048536 started at seq 117150 but completed at seq 
117062
out_of_order: sector 1048544 started at seq 117151 but completed at seq 
117063
out_of_order: sector 1048552 started at seq 117152 but completed at seq 
117064
out_of_order: sector 1048560 started at seq 117153 but completed at seq 
117065
out_of_order: sector 1048568 started at seq 117154 but completed at seq 
117066
ublk selftest: generic_01 done at 2026-01-25T19:08:54+02:00
generic_01 : [FAIL]

consecutive runs are okay

./test_generic_01.sh
ublk selftest: generic_01 starting at 2026-01-25T20:21:31+02:00
ublk selftest: generic_01 done at 2026-01-25T20:21:38+02:00
generic_01 : [PASS]

I went thru the reboot cycle several times - it  repeats.

Tried with and without setting the affinity - and i observed no difference.

I will do some more testing but it was easier to reproduce before that 
patch.

-- 
have fun,
alex
