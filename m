Return-Path: <ve92mose@stud.informatik.uni-erlangen.de>
Date: Thu, 29 Mar 2018 20:27:30 +0200
From: catchall@ghostav.ddnss.de
To: Scott Bauer <scott.bauer@intel.com>
Cc: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>,
	Christoph Hellwig <hch@lst.de>,
	Jonathan Derrick <jonathan.derrick@intel.com>,
	Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 08/11] block: sed-opal: ioctl for writing to shadow mbr
Message-ID: <20180329182730.nrdfgdye5jbark4g@ghostav.ddnss.de>
References: <cover.1520946114.git.jonas.rabenstein@studium.uni-erlangen.de>
 <cover.1521482295.git.jonas.rabenstein@studium.uni-erlangen.de>
 <9f94be9c32887aacdcba75bd6a3902d0350eb987.1521482296.git.jonas.rabenstein@studium.uni-erlangen.de>
 <20180319195224.GA3380@lst.de>
 <20180320093604.qge2sdnc5jrud6kg@studium.uni-erlangen.de>
 <20180320220907.zdzf7baag6haaonm@sbauer-Z170X-UD5>
 <20180321014321.xlkcyvcyr6j3usix@studium.uni-erlangen.de>
 <20180329173002.5mmhnl4urj4wovyo@studium.uni-erlangen.de>
 <20180329171641.5cgnpldzq7j3ndhp@sbauer-Z170X-UD5>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180329171641.5cgnpldzq7j3ndhp@sbauer-Z170X-UD5>
List-ID: <linux-block@vger.kernel.org>

On Thu, Mar 29, 2018 at 11:16:42AM -0600, Scott Bauer wrote:
> Yeah, having to autheticate to write the MBR is a real bummer. Theoretically
> you could dd a the pw struct + the shador MBR into sysfs. But that's
> a pretty disgusting hack just to use sysfs. The other method I thought of
> was to authenticate via ioctl then write via sysfs. We already save the PW
> in-kernel for unlocks, so perhaps we can re-use the save-for-unlock to
> do shadow MBR writes via sysfs?
> 
> Re-using an already exposed ioctl for another purpose seems somewhat dangerous?
> In the sense that what if the user wants to write the smbr but doesn't want to
> unlock on suspends, or does not want their PW hanging around in the kernel.
Well. If we would force the user to a two-step interaction, why not stay
completely in sysfs? So instead of using the save-for-unlock ioctl, we
could export each security provider( (AdminSP, UserSPX, ...) as a sysfs
directory with appropriate files (e.g. mbr for AdminSP) as well as a
'unlock' file to store a users password for the specific locking space
and a 'lock' file to remove the stored password on write to it.
Of course, while this will prevent from reuse of the ioctl and
stays within the same configuration method, the PW will still hang
around in the kernel between 'lock' and 'unlock'.

Another idea I just came across while writing this down:
Instead of storing/releasing the password permanently with the 'unlock' and
'lock' files, those may be used to start/stop an authenticated session.
To make it more clear what I mean: Each ioctl that requires
authentication has a similar pattern:
discovery0, start_session, <do_work>, end_session
Instead of having the combination determined by the ioctl, the 'unlock'
would do discovery0 and start_session while the 'lock' would do the
end_session. The user is free to issue further commands with the
appropriate write/reads to other files of the sysfs-directory.
While this removes the requirement to store the key within kernel space,
the open session handle may be used from everybody with permissions for
read/write access to the sysfs-directory files. So this is not optimal
as not only the user who provided the password will finally be able to use
it.
I already did some basic work to split of the session-information from
the opal_dev struct (initially to reduce the memory-footprint of devices with
currently no active opal-interaction). So I think, I could get a
proof-of-concept of this approach within the next one or two weeks if
there are no objections to the base idea.

Thank you,
 Jonas
