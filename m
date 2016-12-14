Return-Path: <gabriel@krisman.be>
From: Gabriel Krisman Bertazi <gabriel@krisman.be>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, dougmill@linux.vnet.ibm.com,
Subject: Re: [PATCH RESEND v2 1/2] blk-mq: Fix failed allocation path when mapping queues
In-Reply-To: <1481038304-22502-1-git-send-email-krisman@linux.vnet.ibm.com>
Date: Tue, 13 Dec 2016 22:39:02 -0200
Message-ID: <87lgvje449.fsf@krisman.be>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
	micalg=pgp-sha256; protocol="application/pgp-signature"
List-ID: <linux-block@vger.kernel.org>

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


On 12/06/2016 09:31 AM, Gabriel Krisman Bertazi wrote:
> In blk_mq_map_swqueue, there is a memory optimization that frees the
> tags of a queue that has gone unmapped.  Later, if that hctx is remapped
> after another topology change, the tags need to be reallocated.
>
> If this allocation fails, a simple WARN_ON triggers, but the block layer
> ends up with an active hctx without any corresponding set of tags.
> Then, any income IO to that hctx can trigger an Oops.
>
> I can reproduce it consistently by running IO, flipping CPUs on and off
> and eventually injecting a memory allocation failure in that path.
>
> In the fix below, if the system experiences a failed allocation of any
> hctx's tags, we remap all the ctxs of that queue to the hctx_0, which
> should always keep it's tags.  There is a minor performance hit, since
> our mapping just got worse after the error path, but this is
> the simplest solution to handle this error path.  The performance hit
> will disappear after another successful remap.
>
> I considered dropping the memory optimization all together, but it
> seemed a bad trade-off to handle this very specific error case.
>
> This should apply cleanly on top of Jen's for-next branch.

Hi,

I saw this patchset missed the first PR for 4.10, though I'd really like
to see it merged in this cycle, if possible.  If you see anything
particularly concerning about this that I missed, please let me know,
but I fear this has been around for a while without much feedback.

Thanks,

=2D-=20
Gabriel Krisman Bertazi

--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYUJSnAAoJEO9pqxSS5VgPfHsP/R7zVSW6oBeUAqCpF3OM2QRM
FCAcqk+a01sd72SioOvh8cKHcBpXeePZqVKDpge9bNgIbOW4/oQORbIYSWldheTK
vrQ+5D9vCChmhJ89q1yEHdas4nKnw3nV6YzH+cH2+2iagrXrZkfi1VqJZlQn9c+T
FDIGUTou5D7fiUcZtXHJy3VmRRAOilarbgsKtQuj30mV9yPlQAnSOQQAFMCqTH4l
pTPvbKkdDYhvOP+PGHU5RrAPlhYclDcKyYIoFAgObzwDybKCyZipaHYFZGWo/wbZ
U/BGsWFuf5F6yUvvEV68KKpS/EJROkk3yXWScDrJQ7/zwRtMRbXnbzAmy9yn3vAQ
zeZ1Q+685FaOK8TRLKFV8QFxF3ggtPQtFt9lsL+vpLCCkX31YyQm0oI/mT80jTfY
NQkYC9AEJvBWhv7tLbFmVHTJf/SFkpFKljwi86S/CbyibkfM+NC07CzGlr1g2uNW
H3QjR1lZ0kGymJi/kgJou30pfLNrmddAFx3f6a1K1DnOTnfwpCsKEecJFGdxR8V9
3cqx7WN+xd8kVaTeISa1psb/GGv+zUBhkDGybFkYXaKeeEap1QQXBhQgq1R+uAL7
rSq8t7u81Rz9qi7/erMFcvLZio3MmtqmslctqFGHz/Z/YnGwEoAGZcK7O/7TSa8B
qPiezFevabn1avDMA4H/
=ygWN
-----END PGP SIGNATURE-----
--=-=-=--
