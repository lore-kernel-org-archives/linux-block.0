Return-Path: <lsf-pc-bounces@lists.linux-foundation.org>
Date: Thu, 19 Apr 2018 07:43:56 -0700
From: Matthew Wilcox <willy@infradead.org>
To: Jerome Glisse <jglisse@redhat.com>
Message-ID: <20180419144356.GC25406@bombadil.infradead.org>
References: <20180418211939.GD3476@redhat.com> <20180419015508.GJ27893@dastard>
	<20180419143825.GA3519@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20180419143825.GA3519@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>, Michal Hocko <mhocko@kernel.org>,
	linux-block@vger.kernel.org, linux-mm@kvack.org,
	Johannes Weiner <hannes@cmpxchg.org>,
	linux-fsdevel <linux-fsdevel@vger.kernel.org>,
	lsf-pc@lists.linux-foundation.org
Subject: Re: [Lsf-pc] [LSF/MM] schedule suggestion
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <https://lists.linuxfoundation.org/mailman/private/lsf-pc/>
List-Post: <mailto:lsf-pc@lists.linux-foundation.org>
List-Help: <mailto:lsf-pc-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc>,
	<mailto:lsf-pc-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: lsf-pc-bounces@lists.linux-foundation.org
Errors-To: lsf-pc-bounces@lists.linux-foundation.org
List-ID: <linux-block@vger.kernel.org>

On Thu, Apr 19, 2018 at 10:38:25AM -0400, Jerome Glisse wrote:
> Oh can i get one more small slot for fs ? I want to ask if they are
> any people against having a callback everytime a struct file is added
> to a task_struct and also having a secondary array so that special
> file like device file can store something opaque per task_struct per
> struct file.

Do you really want something per _thread_, and not per _mm_?
_______________________________________________
Lsf-pc mailing list
Lsf-pc@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
