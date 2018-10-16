Return-Path: <valdis@vt.edu>
Sender: Valdis Kletnieks <valdis@vt.edu>
From: valdis.kletnieks@vt.edu
To: "Theodore Y. Ts'o" <tytso@mit.edu>, Dennis Zhou <dennisszhou@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [BUG] ext4/block null pointer crashes in linux-next
In-Reply-To: <66480.1539693734@turing-police.cc.vt.edu>
References: <13987.1539646128@turing-police.cc.vt.edu> <20181016015201.GB18547@thunk.org>
 <66480.1539693734@turing-police.cc.vt.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="==_Exmh_1539706333_2381P";
	 micalg=pgp-sha1; protocol="application/pgp-signature"
Date: Tue, 16 Oct 2018 12:12:13 -0400
Message-ID: <12638.1539706333@turing-police.cc.vt.edu>
List-ID: <linux-block@vger.kernel.org>

--==_Exmh_1539706333_2381P
Content-Type: text/plain; charset=us-ascii

On Tue, 16 Oct 2018 08:42:14 -0400, valdis.kletnieks@vt.edu said:

> [~] zgrep CGROUP /proc/config.gz
> CONFIG_CGROUPS=y
> CONFIG_BLK_CGROUP=y
> # CONFIG_DEBUG_BLK_CGROUP is not set
> (...)

> Looks like I should enable DEBUG_BLK_CGROUP and see what that says.

Built next-20181016 with that enabled - and the exact same kablam.

Started looking at the code, and I noticed that if the .config has

CONFIG_IOSCHED_CFQ=y
# CONFIG_CFQ_GROUP_IOSCHED is not set
CONFIG_BLK_CGROUP=y

then the 'struct cfqg_stats' at line 185 of block/cfq-iosched.c ends up being
zero length (which hints that combo of config variables is a pathological
case). I haven't delved through all the #ifdef'ery, but I wonder if there
may be other corner-case issues with that combo....


--==_Exmh_1539706333_2381P
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Comment: Exmh version 2.8.0 04/21/2017

iQEVAwUBW8YN3Y0DS38y7CIcAQKm1Af9E7hXxt6027MX7A17TQoxeQAQZXV4hw+I
/kyOqhvtGZuEr+BQdtXAUpDlQwPs74uQOByPy08dvleO7DwZvS6jbdtZEPyW/kxD
Y1y1SahHpyRXAx2ngE6WSv2kzNGV9KgU5RKMcBNSpX53wM5eRNk+meRPXqgqVaLL
dTe3QL1mcmWrsOX3d35uYbi15q0+2nkXDD7M1oZVaCDenVzxZ8W07KzjzD+swClc
SQV2gQdXnEFBQeEEPuYQQI1Uzy8CItVI+bJ6yO1vc336vtu66sN2w0XIAB2AYi/N
zPbZMcXA+rp37FHc+uYRJBqOSqGfFGBqZNQj97Gc0yO6k3SaI1uhCA==
=X1MR
-----END PGP SIGNATURE-----

--==_Exmh_1539706333_2381P--
