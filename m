Received: from mail.itpri.com (mx1.itpri.com [185.125.111.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8763EBF25
	for <linux-block@vger.kernel.org>; Sat, 31 Jan 2026 10:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.111.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769855439; cv=none; b=VP8CWaWOHvXk3JEC0aXKwwyA2IH0TdIWqf46YZi0XMsUnY6ZNpwmufWheTQmBQ5SEKbiVOvCWjbJ7P2/VMXhyKtPdJclAd194wnszjDxd7EKGsRhl4H/KysfJsoal4O8bVX9KEpHq4B4I/YO/KC6WwhOSueQ2N6U5MBRr5ihouc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769855439; c=relaxed/simple;
	bh=uzma4b7wv9fRj2l20eDv4eTHHblhw07u82lAmt1TaAc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ADozqOZhey4OEVRVFNDcJCWIQmmMZ3XutT5pqu8eFxZEReQBdQsUYNzH8+7O22bOTDEwSL2kOBQv/Wte2zIvTb56jBvPDudHnXDseaujh7lPA2I78wqq78Oc9oRJuXSU8ByPi5POKnKFffJcbm36S9omxJ4DTkDvia0MYGxfRiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com; spf=pass smtp.mailfrom=zazolabs.com; dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b=d4o22cSv; arc=none smtp.client-ip=185.125.111.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zazolabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=zazolabs.com header.i=@zazolabs.com header.b="d4o22cSv"
X-Virus-Scanned: Yes
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=zazolabs.com; s=mail;
	t=1769855428; bh=uzma4b7wv9fRj2l20eDv4eTHHblhw07u82lAmt1TaAc=;
	h=Subject:From:In-Reply-To:Cc:References:To;
	b=d4o22cSv478l1lVdOptBJzQKzPvnyrTK/79t/N/isiRP0lrocfhIq6N31sPIpePAo
	 L5lXsrtt0PQUIxSLYWFY8fRQ03LTklNtuSOOiIaz7gzFZl/CJk51xVA4OfUyM+A2nj
	 6ivcG1RQdxEpWkb4audoaqvoILCW6OEBHVuBy7HeScSJBkCMKJtzLluOwjJ9xn99gq
	 DIILkSuh9UbcqnsHKSU9xZcrZmfGqrMyymb2oIqsuxRNJ4ENz+SOizk2HMOx1sELyq
	 w2gK27dbGd0AYRDcZZQVzRaW87q1MqKCjI/gu7Uuwd/0f2ZiC2djo7YIBgt8c+q2bk
	 GSKu0fgnG1JLJqhRg5hR27eTpznS6cFJLBRysfjXtJ3tj6Ofnv6ZXCxSQZ8MHSkPuX
	 A8l/d1hIF/KaSv96q4Uv1Drrv206/Z8Nl5XjvRYJ6l520QUiT8VG1f7isXqdQwVA5l
	 VvN5Z7bM59wwh43sAkwB+3Nzoq+qUi+ut9bO4OhsHEQKwaFSOvHIKTQWmqOFwyBb2G
	 NkHZUPoc4hV664UAQfmHSGACM7RYFU6eU1lSsw6941D8da+uNsWGrgQmeolBbWGd2d
	 KSgtEAnDYgnj2GrTeZD/IUF+2iUtGHhiRPE1CmaDMmklJnhJPeST+emewuFBPg2f//
	 JKGs2ETYhjzdAWq0yklG7rNw=
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH V2 9/9] selftests: ublk: move test temp files into a sub
 directory
From: Alexander Atanasov <alex@zazolabs.com>
In-Reply-To: <aX1sbrLk-Vv-7rSh@fedora>
Date: Sat, 31 Jan 2026 12:30:15 +0200
Cc: Jens Axboe <axboe@kernel.dk>,
 linux-block@vger.kernel.org,
 Caleb Sander Mateos <csander@purestorage.com>,
 Uday Shankar <ushankar@purestorage.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <75513501-EA90-49C2-9B34-BA4A3342FA7A@zazolabs.com>
References: <20260129162001.3532311-1-ming.lei@redhat.com>
 <20260129162001.3532311-10-ming.lei@redhat.com> <aX1sbrLk-Vv-7rSh@fedora>
To: Ming Lei <ming.lei@redhat.com>

Hi Lei,

> On 31 Jan 2026, at 4:43, Ming Lei <ming.lei@redhat.com> wrote:
>=20
> Hi Alexander,
>=20
> On Fri, Jan 30, 2026 at 12:19:58AM +0800, Ming Lei wrote:
>> From: Alexander Atanasov <alex@zazolabs.com>
>>=20
>> Create and use a temporary directory for the files created during
>> test runs. If TMPDIR environment variable is set use it as a base
>> for the temporary directory path.
>> TMPDIR=3D/mnt/scratch make run_tests
>> and
>> TMPDIR=3D/mnt/scratch ./test_generic_01.sh
>> will place test directory under /mnt/scratch
>>=20
>> Signed-off-by: Alexander Atanasov <alex@zazolabs.com>
>> ---
>> tools/testing/selftests/ublk/test_common.sh | 11 ++++++++---
>> 1 file changed, 8 insertions(+), 3 deletions(-)
>>=20

>> [snip]

>> +export UBLK_TEST_DIR
>=20
> I feel this patch can be simplified in the following way, what do you =
think
> of the change?
>=20
> diff --git a/tools/testing/selftests/ublk/test_common.sh =
b/tools/testing/selftests/ublk/test_common.sh
> index 21ba51fcc7d7..1ee7a898e6bf 100755
> --- a/tools/testing/selftests/ublk/test_common.sh
> +++ b/tools/testing/selftests/ublk/test_common.sh
> @@ -48,7 +48,7 @@ _create_backfile() {
>        old_file=3D"${UBLK_BACKFILES[$index]}"
>        [ -f "$old_file" ] && rm -f "$old_file"
>=20
> -       new_file=3D$(mktemp =
${UBLK_TEST_DIR}/ublk_file_"${new_size}"_XXXXX)
> +       new_file=3D$(mktemp ${TDIR}/ublk_file_"${new_size}"_XXXXX)
>        truncate -s "${new_size}" "${new_file}"
>        UBLK_BACKFILES["$index"]=3D"$new_file"
> }
> @@ -65,7 +65,7 @@ _remove_files() {
> _create_tmp_dir() {
>        local my_file;
>=20
> -       my_file=3D$(mktemp -d ${UBLK_TEST_DIR}/ublk_dir_XXXXX)
> +       my_file=3D$(mktemp -d ${TDIR}/ublk_dir_XXXXX)
>        echo "$my_file"
> }
>=20
> @@ -125,8 +125,7 @@ _prep_test() {
>        shift 1
>        modprobe ublk_drv > /dev/null 2>&1
>        TDIR=3D$(mktemp -d ${TMPDIR:-.}/ublktest-dir.XXXXXX)
> -       export UBLK_TEST_DIR=3D${TDIR}
> -       UBLK_TMP=3D$(mktemp ${UBLK_TEST_DIR}/ublk_test_XXXXX)
> +       UBLK_TMP=3D$(mktemp ${TDIR}/ublk_test_XXXXX)
>        [ "$UBLK_TEST_QUIET" -eq 0 ] && echo "ublk $type: $*"
>        echo "ublk selftest: $TID starting at $(date '+%F %T')" | tee =
/dev/kmsg
> }
> @@ -173,7 +172,7 @@ _cleanup_test() {
>        "${UBLK_PROG}" del -a
>=20
>        _remove_files
> -       rmdir ${UBLK_TEST_DIR}
> +       rmdir ${TDIR}
>        echo "ublk selftest: $TID done at $(date '+%F %T')" | tee =
/dev/kmsg
> }
>=20
> @@ -408,8 +407,6 @@ UBLK_PROG=3D$(_ublk_test_top_dir)/kublk
> UBLK_TEST_QUIET=3D1
> UBLK_TEST_SHOW_RESULT=3D1
> UBLK_BACKFILES=3D()
> -UBLK_TEST_DIR=3D${TMPDIR:-.}
> export UBLK_PROG
> export UBLK_TEST_QUIET
> export UBLK_TEST_SHOW_RESULT
> -export UBLK_TEST_DIR

I think removing the exports at the end is good - every
test will have to go through _prep_test().
But keeping the longer name - UBLK_TEST_DIR vs
TDIR is better since it can be used inside the tests.
UBLK_TEST_DIR is more descriptive than TDIR.

have fun,
alex


