Return-Path: <lsf-pc-bounces@lists.linux-foundation.org>
Date: Wed, 31 Jan 2018 12:42:45 -0500
From: Jerome Glisse <jglisse@redhat.com>
To: Al Viro <viro@ZenIV.linux.org.uk>
Message-ID: <20180131174245.GE2912@redhat.com>
References: <20180130004347.GD4526@redhat.com>
	<20180131165646.GI29051@ZenIV.linux.org.uk>
MIME-Version: 1.0
In-Reply-To: <20180131165646.GI29051@ZenIV.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
	lsf-pc@lists.linux-foundation.org, linux-block@vger.kernel.org
Subject: Re: [Lsf-pc] [LSF/MM TOPIC] Killing reliance on struct page->mapping
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <https://lists.linuxfoundation.org/mailman/private/lsf-pc/>
List-Post: <mailto:lsf-pc@lists.linux-foundation.org>
List-Help: <mailto:lsf-pc-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: lsf-pc-bounces@lists.linux-foundation.org
Errors-To: lsf-pc-bounces@lists.linux-foundation.org
List-ID: <linux-block@vger.kernel.org>

On Wed, Jan 31, 2018 at 04:56:46PM +0000, Al Viro wrote:
> On Mon, Jan 29, 2018 at 07:43:48PM -0500, Jerome Glisse wrote:
> > I started a patchset about $TOPIC a while ago, right now i am working o=
n other
> > thing but i hope to have an RFC for $TOPIC before LSF/MM and thus would=
 like a
> > slot during common track to talk about it as it impacts FS, BLOCK and M=
M (i am
> > assuming their will be common track).
> > =

> > Idea is that mapping (struct address_space) is available in virtualy al=
l the
> > places where it is needed and that their should be no reasons to depend=
 only on
> > struct page->mapping field. My patchset basicly add mapping to a bunch =
of vfs
> > callback (struct address_space_operations) where it is missing, changin=
g call
> > site. Then i do an individual patch per filesystem to leverage the new =
argument
> > instead on struct page.
> =

> Oh?  What about the places like fs/coda?  Or block devices, for that matt=
er...
> You can't count upon file->f_mapping->host =3D=3D file_inode(file).

What matter is that the place that call an address_space_operations callback
already has mapping =3D=3D page->mapping in many places this is obvious. For
instance page just have been looked up using mapping and thus you must have
mapping =3D=3D page->mapping. But i believe this holds in all places. They =
are
few dark corners (fuse, splice, ...). Truncate also factor in all this as
page->mapping is use to determine if a page has been truncated, but it
should not be an issue.

So i am not counting on file->f_mapping->host =3D=3D file_inode(file) but i=
 might
count in _some_ place on vma->file->f_mapping =3D=3D page->mapping of any n=
on private
page inside that vma. AFAICT this holds for coda and should hold elsewhere =
too.

For block devices the idea is to use struct page and buffer_head (first one=
 of
a page) as a key to find mapping (struct address_space) back.

The overall idea i have is that in any place in the kernel (except memory r=
eclaim
but that's ok) we can either get mapping or buffer_head information without=
 relying
on struct page and if we have either one and a struct page then we can find=
 the
other one.

Like i said i am not done with a patchset for that yet so maybe i am too
optimistic. I have another patchset i need to finish first before i go back=
 to
this. I hope to have an RFC sometime in February or March and maybe by then
i would have found a roadblock, i am crossing my fingers until then :)

If it turns out that it is not doable i will comment on this thread and we =
can
kill that of from the agenda.

Cheers,
J=E9r=F4me
_______________________________________________
Lsf-pc mailing list
Lsf-pc@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
