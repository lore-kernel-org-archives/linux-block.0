Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54B92FA0C6;
	Mon, 26 Jan 2026 08:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769416457; cv=none; b=SsAK7fl4W2L5WkqEpfvVsuejmOtjjTyZNbApCEE7t26hJ/l6HdnVSX7yWNAEaz7OozV/zGtTqhMLnBMFZzTgopoo+5RTO2k8oJZy26ditXz9MY5mKdFqIWTa3sw35j2OmgtLKH9s522I0cOHXJ02TDgNi2o80I+GheIhtF8IboI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769416457; c=relaxed/simple;
	bh=x6dG68/K5l0AwsEc8UvHDxe8a9IktxU8g4/oqzGOqRU=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=mqTKTV0EgIo8oKVMT2rAmIuCO6UOPR3hrKDVEiX8sTkbp+NSFrgaMzmJSp/TRROoVPotkCiRgP+gQffR1WIqrgSj7TduvOuN/X89Nk45yMhI8+hq1L/rDebzYk5q9KDL3coc64L394we927SpSIJYchcUWZoOlEk3iyl0NHc59E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=Bv/AF/cl; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="Bv/AF/cl"
X-Virus-Scanned: Yes
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1769416450; bh=x6dG68/K5l0AwsEc8UvHDxe8a9IktxU8g4/oqzGOqRU=;
	h=Subject:From:In-Reply-To:Cc:References:To;
	b=Bv/AF/clkueQN9G2Z9nxzWPhTFJk/ukB5GE2jg6XqCKRft39YdrDFq3wn14Wfa9vD
	 aECYqv0RUhNAdUB0j6q2/BH8M6EakcCLwesIU9ds8mW8vL0S4rDaEohCLYUO9OX2+5
	 Qy9odTg9AmLwYm3TvUUTos92czumizVPnlyI172LC/RtycmmI1c7pLe0Vtw0sUv1Jy
	 oCwmQlbas7nKnRZACftzEBcz5hYqrBbxz1XdETsQj4anGOcnLBYMSIKM71Zq8dVKXS
	 OeRni2sxH61HuHW7B4B3FI60gNo9j6nckCJTd4Y8tqXRmzq9nOTPz6uxBluJaLo7h4
	 g7yy3kedg8nK653bOoESjArHeDpRQwd4EZLqKVme1s7dx0MA/VttPRIsu9U6unNtOB
	 ecnGvrViC//Zfng72/OYg+gK0LpS0KoG82tDnOwHLh7BDhKIKSveISUT3dLt6v8V8t
	 AsOaBs5E84UAECAjxcd9742wi4cp6YIa3LwfERJ6VmU/P3ohfE6YFTAbWrt2cbNV4V
	 8aIL3BIItnqFM4egMsOERjGjk+VdpAHjGTsV5sg6KmlznKkvSAt4yNX8uNdsI/cS1d
	 Nt/+gN+1qNjKRER9RK1KGsbdgsklSXZfwSmWLC827uw9B4enHdlRQaq4XuyU8wGXq8
	 1bKXSkkb5M1/8eS1uIEn7P/I=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] selftests: ublk: io-reorder triggered in
 test_generic_01.sh
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <aXbDCtZ8fvljMEsC@fedora>
Date: Mon, 26 Jan 2026 10:33:58 +0200
Cc: alex+zkern@zazolabs.com,
 Shuah Khan <shuah@kernel.org>,
 linux-block@vger.kernel.org,
 linux-kselftest@vger.kernel.org,
 linux-kernel@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <7B09D8AA-C725-432A-AE85-D7CC620836EC@zazolabs.com>
References: <20260123112039.1370223-1-alex@zazolabs.com>
 <aXN4mFuoXhtJDKyF@fedora> <147635F1-943E-46D5-8EF1-D1C965F85EC1@zazolabs.com>
 <aXOGrXo3AbXPHA-K@fedora> <03C8F5B9-B2E1-4C78-A043-B4F9422508B7@zazolabs.com>
 <aXY2qdYtfVTSc7jB@fedora> <c517e1ca-0e2b-4143-b0f6-07a3d0c3abcf@zazolabs.com>
 <aXbDCtZ8fvljMEsC@fedora>
To: Ming Lei <ming.lei@redhat.com>

Hello,

> On 26 Jan 2026, at 3:27, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> On Sun, Jan 25, 2026 at 08:35:20PM +0200, Alexander Atanasov wrote:
>> On 25.01.26 17:28, Ming Lei wrote:
>>> On Fri, Jan 23, 2026 at 05:00:33PM +0200, Alexander Atanasov wrote:
>>>>=20
>>>>=20
>>=20
>> [snip]
>>=20
>>> Can you test the following patch and see if re-order still can =
happen?
>>>=20
>>>=20
>>> diff --git a/tools/testing/selftests/ublk/test_generic_01.sh =
b/tools/testing/selftests/ublk/test_generic_01.sh
>>> index 26cf3c7ceeb5..26d5e52ece29 100755
>>> --- a/tools/testing/selftests/ublk/test_generic_01.sh
>>> +++ b/tools/testing/selftests/ublk/test_generic_01.sh
>>> @@ -13,7 +13,7 @@ if ! _have_program fio; then
>>>   exit "$UBLK_SKIP_CODE"
>>>  fi
>>> -_prep_test "null" "sequential io order"
>>> +_prep_test "null" "ublk dispatch won't reorder IO"
>>>  dev_id=3D$(_add_ublk_dev -t null)
>>>  _check_add_dev $TID $?
>>> @@ -39,9 +39,13 @@ fio --name=3Dwrite_seq \
>>>  ERR_CODE=3D$?
>>>  kill "$btrace_pid"
>>>  wait
>>> -if grep -q "io_out_of_order" "$UBLK_TMP"; then
>>> - cat "$UBLK_TMP"
>>> +
>>> +# Check for out-of-order completions detected by bpftrace
>>> +if grep -q "^out_of_order:" "$UBLK_TMP"; then
>>> + echo "I/O reordering detected:"
>>> + grep "^out_of_order:" "$UBLK_TMP"
>>>   ERR_CODE=3D255
>>>  fi
>>> +
>>>  _cleanup_test "null"
>>>  _show_result $TID $ERR_CODE
>>> diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt =
b/tools/testing/selftests/ublk/trace/seq_io.bt
>>> index b2f60a92b118..60ac40e66606 100644
>>> --- a/tools/testing/selftests/ublk/trace/seq_io.bt
>>> +++ b/tools/testing/selftests/ublk/trace/seq_io.bt
>>> @@ -2,23 +2,45 @@
>>>   $1:  dev_t
>>>   $2:  RWBS
>>>   $3:     strlen($2)
>>> +
>>> + Track request order between block_io_start and block_rq_complete.
>>> + For each request, record its start sequence number and verify
>>> + completions happen in the same order.
>>>  */
>>> +
>>>  BEGIN {
>>> - @last_rw[$1, str($2)] =3D (uint64)0;
>>> + @start_seq =3D (uint64)0;
>>> + @complete_seq =3D (uint64)0;
>>> + @out_of_order =3D (uint64)0;
>>> +}
>>> +
>>> +tracepoint:block:block_io_start
>>> +{
>>> + if ((int64)args.dev =3D=3D $1 && !strncmp(args.rwbs, str($2), $3)) =
{
>>> + @start_order[args.sector] =3D @start_seq;
>>> + @start_seq =3D @start_seq + 1;
>>> + }
>>>  }
>>> +
>>>  tracepoint:block:block_rq_complete
>>>  {
>>> - $dev =3D $1;
>>>   if ((int64)args.dev =3D=3D $1 && !strncmp(args.rwbs, str($2), $3)) =
{
>>> - $last =3D @last_rw[$dev, str($2)];
>>> - if ((uint64)args.sector !=3D $last) {
>>> - printf("io_out_of_order: exp %llu actual %llu\n",
>>> - args.sector, $last);
>>> + $expected_order =3D @start_order[args.sector];
>>> + if ($expected_order !=3D @complete_seq) {
>>> + printf("out_of_order: sector %llu started at seq %llu but =
completed at seq %llu\n",
>>> + args.sector, $expected_order, @complete_seq);
>>> + @out_of_order =3D @out_of_order + 1;
>>>   }
>>> - @last_rw[$dev, str($2)] =3D (args.sector + args.nr_sector);
>>> + delete(@start_order[args.sector]);
>>> + @complete_seq =3D @complete_seq + 1;
>>>   }
>>>  }
>>>  END {
>>> - clear(@last_rw);
>>> + printf("total_start: %llu total_complete: %llu out_of_order: =
%llu\n",
>>> + @start_seq, @complete_seq, @out_of_order);
>>> + clear(@start_order);
>>> + clear(@start_seq);
>>> + clear(@complete_seq);
>>> + clear(@out_of_order);
>>>  }
>>=20
>>=20
>> First run after reboot always fails:
>>=20
>> ./test_generic_01.sh
>> ublk selftest: generic_01 starting at 2026-01-25T19:08:47+02:00
>> I/O reordering detected:
>> out_of_order: sector 112040 started at seq 88 but completed at seq 0
>> out_of_order: sector 112048 started at seq 89 but completed at seq 1
>> out_of_order: sector 112056 started at seq 90 but completed at seq 2
>> out_of_order: sector 112064 started at seq 91 but completed at seq 3
>> out_of_order: sector 112072 started at seq 92 but completed at seq 4
>> out_of_order: sector 112080 started at seq 93 but completed at seq 5
>> out_of_order: sector 112088 started at seq 94 but completed at seq 6
>> out_of_order: sector 112096 started at seq 95 but completed at seq 7
>> out_of_order: sector 112104 started at seq 96 but completed at seq 8
>> out_of_order: sector 112112 started at seq 97 but completed at seq 9
>> out_of_order: sector 112120 started at seq 98 but completed at seq 10
>> out_of_order: sector 112128 started at seq 99 but completed at seq 11
>=20
> In the 1st bpf attachment, fio may be started between attaching
> block_start_req and block_complete_req. Maybe the following patch can
> solve it:
>=20
>=20
> diff --git a/tools/testing/selftests/ublk/test_generic_01.sh =
b/tools/testing/selftests/ublk/test_generic_01.sh
> index 26cf3c7ceeb5..15cea9e55e1c 100755
> --- a/tools/testing/selftests/ublk/test_generic_01.sh
> +++ b/tools/testing/selftests/ublk/test_generic_01.sh
> @@ -13,7 +13,7 @@ if ! _have_program fio; then
> exit "$UBLK_SKIP_CODE"
> fi
>=20
> -_prep_test "null" "sequential io order"
> +_prep_test "null" "ublk dispatch won't reorder IO"
>=20
> dev_id=3D$(_add_ublk_dev -t null)
> _check_add_dev $TID $?
> @@ -21,15 +21,20 @@ _check_add_dev $TID $?
> dev_t=3D$(_get_disk_dev_t "$dev_id")
> bpftrace trace/seq_io.bt "$dev_t" "W" 1 > "$UBLK_TMP" 2>&1 &
> btrace_pid=3D$!
> -sleep 2
>=20
> -if ! kill -0 "$btrace_pid" > /dev/null 2>&1; then
> +# Wait for bpftrace probes to be attached (BEGIN block prints =
BPFTRACE_READY)
> +for _ in $(seq 100); do
> + grep -q "BPFTRACE_READY" "$UBLK_TMP" 2>/dev/null && break
> + sleep 0.1
> +done
> +
> +if ! kill -0 "$btrace_pid" 2>/dev/null; then
> _cleanup_test "null"
> exit "$UBLK_SKIP_CODE"
> fi
>=20
> -# run fio over this ublk disk
> -fio --name=3Dwrite_seq \
> +# run fio over this ublk disk (pinned to CPU 0)
> +taskset -c 0 fio --name=3Dwrite_seq \
>     --filename=3D/dev/ublkb"${dev_id}" \
>     --ioengine=3Dlibaio --iodepth=3D16 \
>     --rw=3Dwrite \
> @@ -39,9 +44,13 @@ fio --name=3Dwrite_seq \
> ERR_CODE=3D$?
> kill "$btrace_pid"
> wait
> -if grep -q "io_out_of_order" "$UBLK_TMP"; then
> - cat "$UBLK_TMP"
> +
> +# Check for out-of-order completions detected by bpftrace
> +if grep -q "^out_of_order:" "$UBLK_TMP"; then
> + echo "I/O reordering detected:"
> + grep "^out_of_order:" "$UBLK_TMP"
> ERR_CODE=3D255
> fi
> +
> _cleanup_test "null"
> _show_result $TID $ERR_CODE
> diff --git a/tools/testing/selftests/ublk/trace/seq_io.bt =
b/tools/testing/selftests/ublk/trace/seq_io.bt
> index b2f60a92b118..8ebe13d24c67 100644
> --- a/tools/testing/selftests/ublk/trace/seq_io.bt
> +++ b/tools/testing/selftests/ublk/trace/seq_io.bt
> @@ -2,23 +2,64 @@
> $1:  dev_t
> $2:  RWBS
> $3:     strlen($2)
> +
> + Track request order between block_io_start and block_rq_complete.
> + For each request, record its start sequence number and verify
> + completions happen in the same order.
> +
> + Sequence starts at 1 so that 0 means "never seen" (bpftrace maps
> + return 0 for missing keys). On first valid completion, sync
> + complete_seq to handle probe attachment races.
> +
> + block_rq_complete is listed first to ensure it's attached before
> + block_io_start, reducing the window for missed completions.
> */
> +
> BEGIN {
> - @last_rw[$1, str($2)] =3D (uint64)0;
> + @start_seq =3D (uint64)1;
> + @complete_seq =3D (uint64)0;
> + @out_of_order =3D (uint64)0;
> + /* Initialize map type with dummy entry */
> + @start_order[0] =3D (uint64)0;
> + delete(@start_order[0]);
> + printf("BPFTRACE_READY\n");
> }
> +
> tracepoint:block:block_rq_complete
> {
> - $dev =3D $1;
> if ((int64)args.dev =3D=3D $1 && !strncmp(args.rwbs, str($2), $3)) {
> - $last =3D @last_rw[$dev, str($2)];
> - if ((uint64)args.sector !=3D $last) {
> - printf("io_out_of_order: exp %llu actual %llu\n",
> - args.sector, $last);
> + $expected =3D @start_order[args.sector];
> + if ($expected > 0) {
> + /* Sync complete_seq on first valid completion */
> + if (@complete_seq =3D=3D 0) {
> + @complete_seq =3D $expected;
> + }
> +
> + if ($expected !=3D @complete_seq) {
> + printf("out_of_order: sector %llu started at seq %llu but completed =
at seq %llu\n",
> + args.sector, $expected, @complete_seq);
> + @out_of_order =3D @out_of_order + 1;
> + }
> + delete(@start_order[args.sector]);
> + @complete_seq =3D @complete_seq + 1;
> }
> - @last_rw[$dev, str($2)] =3D (args.sector + args.nr_sector);
> + /* $expected =3D=3D 0 means we never saw this sector start, skip it =
*/
> + }
> +}
> +
> +tracepoint:block:block_io_start
> +{
> + if ((int64)args.dev =3D=3D $1 && !strncmp(args.rwbs, str($2), $3)) {
> + @start_order[args.sector] =3D @start_seq;
> + @start_seq =3D @start_seq + 1;
> }
> }
>=20
> END {
> - clear(@last_rw);
> + printf("total_start: %llu total_complete: %llu out_of_order: =
%llu\n",
> + @start_seq - 1, @complete_seq, @out_of_order);
> + clear(@start_order);
> + clear(@start_seq);
> + clear(@complete_seq);
> + clear(@out_of_order);
> }
>=20


This solves it - no more out of order detected.

Looks like this auto mount explains why it misses a few seqs on the =
first run.=20

[   99.548551] ublk selftest: generic_01 starting at =
2026-01-26T10:24:07+02:00
[  104.173575] NOTICE: Automounting of tracing to debugfs is deprecated =
and will be removed in 2030
[  112.680519] ublk selftest: generic_01 done at =
2026-01-26T10:24:20+02:00
[  116.564281] ublk selftest: generic_01 starting at =
2026-01-26T10:24:24+02:00
[  130.658273] ublk selftest: generic_01 done at =
2026-01-26T10:24:38+02:00


have fun,
alex



